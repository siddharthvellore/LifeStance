terraform {
  required_providers {
    aws = "~> 3.0"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "sid"
}

resource "aws_s3_bucket" "b" {
  bucket = "sid-terraform-state-lock"
  acl    = "private"

  tags = {
    Name        = "sid-bucket"
    Environment = "testing"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
  name = "sid-terraform-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = "true"
    kms_key_arn = "arn:aws:kms:us-east-1:417311935802:key/77b7856b-2c29-4cd0-bd12-45fd22204afe"
  }
  point_in_time_recovery {
    enabled = "true"
  }
}