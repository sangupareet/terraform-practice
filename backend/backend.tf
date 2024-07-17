terraform {
  backend "s3" {
    bucket = "mudhol"
    region = "ap-south-1"
    key = "terraform.tfstate"
    dynamodb_table = "dynamodb-state-lock"
    encrypt = true
  }
}