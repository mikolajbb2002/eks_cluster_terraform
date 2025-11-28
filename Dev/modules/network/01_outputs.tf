output "vpc_id" {
  description = "Identifier of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Identifiers of the public subnets."
  value = [
    aws_subnet.public_az1.id,
    aws_subnet.public_az2.id,
  ]
}

variable "destination_cidr_block" {
  description = "CIDR block for internet-bound traffic."
  type        = string 
}

output "internet_gateway_id" {
  description = "Identifier of the internet gateway attached to the VPC."
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "Route table handling the public subnets."
  value       = aws_route_table.public.id
}
