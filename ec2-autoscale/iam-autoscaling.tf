# # scale up alarm
# resource "aws_autoscaling_policy" "main-up" {
#   name                   = "policy-cpu-${var.AppName}-up"
#   autoscaling_group_name = aws_autoscaling_group.main.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "1"
#   cooldown               = "300"
#   policy_type            = "SimpleScaling"
# }

# resource "aws_cloudwatch_metric_alarm" "main-up" {
#   alarm_name          = "cpu-alarm-${var.AppName}-up"
#   alarm_description   = "scale up alarm form ${var.AppName}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "30"

#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.main-up.arn]

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.main.name
#   }

# }


# # scale down alarm
# resource "aws_autoscaling_policy" "main-down" {
#   name                   = "policy-cpu-${var.AppName}-down"
#   autoscaling_group_name = aws_autoscaling_group.main.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "-1"
#   cooldown               = "300"
#   policy_type            = "SimpleScaling"
# }

# resource "aws_cloudwatch_metric_alarm" "main-down" {
#   alarm_name          = "cpu-alarm-${var.AppName}-down"
#   alarm_description   = "scale down alarm form ${var.AppName}"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "5"

#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.main-down.arn]

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.main.name
#   }

# }