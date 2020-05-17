data "aws_ip_ranges" "tokyo_ec2" {
  regions  = ["ap-northeast-1"]
  services = ["ec2"]
}

resource "aws_security_group" "from_tokyo" {
  name = "from_tokyo"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = [22, 80, 443]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [ingress.value == 22 ? "118.86.160.25/32" : "0.0.0.0/0"]
    }
  }

  tags = {
    CreateDate = data.aws_ip_ranges.tokyo_ec2.create_date
    SyncToken  = data.aws_ip_ranges.tokyo_ec2.sync_token
  }
}