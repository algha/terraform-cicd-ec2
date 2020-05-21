output "public-ip" {
  value = aws_instance.main.public_ip
}

output "elastic-ip" {
  value = "${join(", ", aws_eip.main.*.public_ip)}"
}