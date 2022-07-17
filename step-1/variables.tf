variable "vpc_name" {
  description = "AWS Management VPC name"
  default     = "management-vpc"
}

variable "vpc_cidr" {
  description = "AWS Management VPC CIDR Block"
  default     = "10.255.0.0/23"
}

variable "igw_name" {
  description = "AWS Internet Gateway name"
  default     = "management-igw"
}

variable "create_public_subnet2" {
  description = "AWS Internet Gateway name"
  type        = bool
  default     = true
}