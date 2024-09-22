provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket         = "janos3backend" # bucket name
    key            = "global/janostatefile/terraform.tfstate" # state file location in S3
    region         = "ap-southeast-1" # region
    dynamodb_table = "janostatelock" # state locking using dynamoDB table 
  }
}