
output "vpc_id" {
  description = "ID of the Inventory Manager VPC"
  value       = aws_vpc.inventory.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.inventory.id
}
output "web_security_group_id" {
  description = "ID of the Inventory Manager web security group"
  value       = aws_security_group.web.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}
