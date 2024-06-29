resource "aws_lb_target_group" "telus" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.telus.id
  target_type = "instance"
  health_check {
    path                = "/"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
  tags = var.tags_all
}

resource "aws_lb" "telus_lb" {
  name            = "${var.name}-lb"
  subnets         = [aws_subnet.telus_public_subnet1.id, aws_subnet.telus_public_subnet2.id]
  security_groups = [aws_security_group.telus_lb.id]
  tags            = var.tags_all
}

resource "aws_lb_listener" "telus_lb_listener" {
  load_balancer_arn = aws_lb.telus_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.telus.arn
    type             = "forward"
  }
}

resource "aws_autoscaling_attachment" "telus_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.telus.id
  lb_target_group_arn    = aws_lb_target_group.telus.arn
}