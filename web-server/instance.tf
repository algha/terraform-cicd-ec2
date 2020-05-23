resource "aws_instance" "main" {
  ami           = var.AMI
  instance_type = var.InstanceType
  key_name = aws_key_pair.main.key_name
  subnet_id = var.SubnetId
  vpc_security_group_ids = [aws_security_group.ec2-instance.id]
  # role
  iam_instance_profile = aws_iam_instance_profile.ec2-instance.id

  monitoring = true

  tags = {
    Name = "ec2-${var.AppName}"
    App  = var.AppName
  }

  # Root ebs size
  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.InstanceUsername
    private_key = file("${path.module}/keys/secret.key")
  }

  provisioner "file" {
    source      = "${path.module}/scripts/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
}
