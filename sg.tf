resource "aws_security_group" "telus_lb" {
  name   = "${var.name}-lb-sg"
  vpc_id = aws_vpc.telus.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags_all
}

resource "aws_security_group" "telus_ec2" {
  name   = "${var.name}-ec2-sg"
  vpc_id = aws_vpc.telus.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.telus_lb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags_all
}