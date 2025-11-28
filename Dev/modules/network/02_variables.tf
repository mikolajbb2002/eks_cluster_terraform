variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = ""
}

variable "az1" {
  description = "Availability zone for the first set of subnets."
  type        = string
}

variable "az2" {
  description = "Availability zone for the second set of subnets."
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for the public subnet in az1."
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for the public subnet in az2."
  type        = string
}
