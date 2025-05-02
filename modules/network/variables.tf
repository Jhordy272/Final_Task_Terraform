variable "vpc_id" {
  description = "The ID of the VPC where the network resources will be created."
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway to attach to the VPC."
  type        = string
}