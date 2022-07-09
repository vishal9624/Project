terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.12.0"
    }
}
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "project_terraform" {
  bucket = "terraform-state-files-98676"
}

resource "aws_s3_bucket_versioning" "terraformstate" {
  bucket = aws_s3_bucket.project_terraform.id

  versioning_configuration {
    status = "Enabled"
  }
}