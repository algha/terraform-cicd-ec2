# resource "aws_launch_configuration" "main" {
#   name_prefix   = "launchconfig-${var.AppName}"
#   image_id      = var.AMI
#   instance_type = var.InstanceType
#   key_name = aws_key_pair.main.key_name
#   security_groups = [aws_security_group.ec2-instance.id]
# }

# resource "aws_autoscaling_group" "main" {
#   name                = "autoscaling-${var.AppName}"
#   vpc_zone_identifier = [var.SubnetId]

#   launch_configuration = aws_launch_configuration.main.name

#   min_size                  = 1
#   max_size                  = 3
#   health_check_grace_period = 300
#   health_check_type         = "EC2"
#   force_delete              = true

#   tag {
#     key                 = "App"
#     value               = var.AppName
#     propagate_at_launch = true
#   }

#   tag {
#     key     = "Name"
#     value   = "ec2-${var.AppName}"
#     propagate_at_launch = true
#   }

# }