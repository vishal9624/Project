provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = "${var.base["region"]}"
}

terraform {
  backend "s3" {
    bucket = "my_s3_bucket"
    key    = "backend/state"
    region = "us-east-1"
    access_key = "<access-key>"
    secret_key = "<secret-key>"
    encrypt = true
    shared_credentials_file = "~/.aws/credentials"
  }
}