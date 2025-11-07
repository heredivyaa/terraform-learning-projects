provider "aws" {
  region = "ap-south-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-087d1c9a513324697"
  instance_type_value = "t3.micro"
}
