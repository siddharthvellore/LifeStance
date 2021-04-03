variable "region" {
  description = "us-east-1"
}

variable "environment" {
  description = "The Deployment environment"
}

variable "profile" {
  description = "AWS Profile"
  default = "sid"
}

//Networking
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
}

variable "availability_zones" {
  type          = list
  default       = ["us-east-1a"]
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
}

variable "name" {
  description = "Resource name. This will be used as a tag prefix"
  default = "lifestance-assignment"
}

# Instance 

variable "ami" {
  type          = string
  default       = "ami-04169656fea786776"
}

variable "instance_count" {
  type = number
  description = "Instance Count"
  default = "2"
}

variable "instance_name" {
  description   = "Value of the Name tag for the EC2 instance"
  type          = string
  default       = "Lifestance-Ec2"
}

variable "key_name" {
  type          = string
  default       = "lifestance-test"
}

variable "instance_type" {
  type          = string
  default       = "t3.micro"
}