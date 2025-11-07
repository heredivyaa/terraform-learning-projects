provider "aws" {
  region = "ap-south-1" #set your region
}

          #resource_type #resource_name
resource "aws_instance" "example" {
  ami           = "ami-087d1c9a513324697" #ami id
  instance_type = "t3.micro"
}
