
variable "region" {
  description = " my region"
  type = string
  default = "us-east-1"
}


variable "example_vpc" {
  description = " my vpc name"
  type = string
}

variable "cidr_block_vpc" {
  description = " my cidr block for my vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "cidr_block_public_subnet" {
  description = "my cidr block for my public subnet"
  type = string
  default = "10.0.1.0/24"
}

variable "availability_zone-public_subnet" {
  description = " my az for public subnet"
  type = string
  default = "us-east-1a"
}


variable "cidr_block_private_subnet" {
  description = " my cidr block for my private subnet"
  type = string
  default = "10.0.1.0/24"
}

variable "availability_zone-private_subnet" {
  description = " my az for public subnet"
  type = string
  default = "us-east-1b"
}


variable "ami" {
  description = " my amazone image for my public ec2"
  type = string
  default = "ami-051f8a213df8bc089"
}