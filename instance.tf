resource "aws_instance" "cicdtest" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.cicd.key_name

  vpc_security_group_ids = [aws_security_group.from_tokyo.id]

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

