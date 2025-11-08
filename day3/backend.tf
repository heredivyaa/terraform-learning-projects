# terraform {
#   backend "s3" {
#     bucket = "divya-s3-demo-abc"
#     key = "day3/terraform.tfstate"
#     region = "ap-south-1"
#     dynamodb_table = "terraform_lock"
#   }
# }