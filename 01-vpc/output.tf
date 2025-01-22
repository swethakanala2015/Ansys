output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets created within the VPC"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets created within the VPC"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway attached to the VPC"
  value       = aws_internet_gateway.gw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway, if created"
  value       = var.enable_nat ? aws_nat_gateway.example[0].id : null
}

output "route_table_public_id" {
  description = "The ID of the route table for public subnets"
  value       = aws_route_table.public.id
}

output "route_table_private_id" {
  description = "The ID of the route table for private subnets"
  value       = aws_route_table.private.id
}