resource "aws_autoscaling_group" "telus" {
  name                      = "${var.name}-asg"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_template {
    id      = aws_launch_template.telus.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.telus_private_subnet.id]
  target_group_arns   = [aws_lb_target_group.telus.arn]
  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
  tag {
    key                 = "Purpose"
    value               = "Assesment"
    propagate_at_launch = true
  }
  # Lifecycle rule is required to redeploy the ASG without downtime
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "telus" {
  name_prefix            = var.name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = "telus"
  vpc_security_group_ids = [aws_security_group.telus_ec2.id]
  user_data              = base64encode(file("user_data.sh"))
  description            = "${var.name} ASG Instance"
  iam_instance_profile {
    name = aws_iam_instance_profile.telus.name
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = var.name
      Purpose = "Assesment"
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "telus_scale_up" {
  name                   = "${var.name}-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.telus.name
}

resource "aws_cloudwatch_metric_alarm" "telus_cpu_high" {
  alarm_name          = "${var.name}-cpu-high-alarm"
  alarm_description   = "Alarm when CPU usage is above 90%"
  alarm_actions       = [aws_autoscaling_policy.telus_scale_up.arn]
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"
  threshold           = "90"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.telus.name
  }
  tags = var.tags_all
}

resource "aws_autoscaling_policy" "telus_scale_down" {
  name                   = "${var.name}-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.telus.name
}

resource "aws_cloudwatch_metric_alarm" "telus_cpu_low" {
  alarm_name          = "${var.name}-cpu-low-alarm"
  alarm_description   = "Alarm when CPU usage is below 40%"
  alarm_actions       = [aws_autoscaling_policy.telus_scale_down.arn]
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"
  threshold           = "40"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.telus.name
  }
  tags = var.tags_all
}

resource "aws_iam_instance_profile" "telus" {
  name = var.name
  role = aws_iam_role.telus.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    effect = "Allow"
  }
}
resource "aws_iam_role" "telus" {
  name               = var.name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}