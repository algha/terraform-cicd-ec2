resource "aws_instance" "cicdtest" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"

  # ssh key pair
  key_name = aws_key_pair.cicd.key_name

  # VPC subnet id
  subnet_id = var.SUBNET_MAIN_PUBLIC_1

  # attach security group id
  vpc_security_group_ids = [aws_security_group.from_tokyo.id]

  # role
  iam_instance_profile = aws_iam_instance_profile.codedeploy-profile.name

  tags = {
    name = "CICDinstance"
  }

  # Root ebs size
  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }


  provisioner "file" {
    source      = "scripts/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.cicdtest.private_ip} >> ./outputs/private_ips.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_PRIVATE_KEY)
  }
}

output "ip" {
  value = aws_instance.cicdtest.public_ip
}

