provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ab" {
    ami = "ami-087d1c9a513324697"
  instance_type = "t3.micro"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "divya-s3-demo-abc"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "lockID"
    type = "5"
  }

}