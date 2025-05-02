output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "security_groups_ids" {
  description = "The IDs of the security groups"
  value       = [aws_security_group.ec2_sg.id]
}

output "elb_name" {
  description = "The name of the ELB"
  value       = aws_elb.elb.name
}