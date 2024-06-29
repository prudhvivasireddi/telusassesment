output "lb_dns_name" {
  value       = aws_lb.telus_lb.dns_name
  description = "DNS Name of the Load Balancer"
}

output "telus_public_subnet1" {
  value       = aws_subnet.telus_public_subnet1.id
  description = "Public Subnet 1 ID"
}

output "telus_public_subnet2" {
  value       = aws_subnet.telus_public_subnet2.id
  description = "Public Subnet 2 ID"
}

output "telus_private_subnet" {
  value       = aws_subnet.telus_private_subnet.id
  description = "Private Subnet ID"
}

output "telus_nat_eip1" {
  value       = aws_eip.telus_nat_eip1.public_ip
  description = "Elastic IP of the NAT Gateway"
}

output "telus_nat_eip2" {
  value       = aws_eip.telus_nat_eip2.public_ip
  description = "Elastic IP of the NAT Gateway"
}

output "lb_security_group_id" {
  value       = aws_security_group.telus_lb.id
  description = "Security Group ID of the Load Balancer"
}

output "ec2_security_group_id" {
  value       = aws_security_group.telus_ec2.id
  description = "Security Group ID of the EC2 Instance"
}