variable "ami" {
  type          = string
  default       = "ami-04169656fea786776"
}

variable "instance_type" {
  type          = string
  default       = "t2.micro"
}

variable "vpc_security_group_ids" {
  type = string
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

variable "subnet_id" {
  type          = string
}