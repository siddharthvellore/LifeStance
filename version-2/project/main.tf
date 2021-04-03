#Stores Stack State on S3 and DynamoDB for Continuous Delivery updates
terraform {
    backend "s3" {
      bucket         = "sid-terraform-state-lock"
      key            = "lifestance-project.tf"
      region         = "us-east-1"
      profile        = "sid"
      kms_key_id     = "arn:aws:kms:us-east-1:417311935802:key/77b7856b-2c29-4cd0-bd12-45fd22204afe"
      encrypt        = "true"
      dynamodb_table = "sid-terraform-state-lock"
    }
  required_providers {
    aws = "~> 3.0"
  }
}

#Input the profile params
provider "aws" {
  region  = var.region
  profile = var.profile
}

#Run the VPC Module
module "networking" {
source = "../modules/vpc"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = var.availability_zones
}

#Run the SecurityGroup Module
module "security_group" {
  source = "../modules/secuitygroup"
  depends_on = [module.networking]
  vpc_id = module.networking.vpc_id
}

#Run the Ec2 Module
module "instance_module" {
source = "../modules/compute"
depends_on = [module.security_group]
  ami = var.ami
  instance_type = var.instance_type
  instance_name = var.instance_name
  vpc_security_group_ids = module.security_group.security_group_id
  subnet_id = flatten([module.networking.private_subnets_id])[0]
}