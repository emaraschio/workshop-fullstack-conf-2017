# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

# Create an EC2 instance
resource "aws_instance" "example_fullstack_conf" {
  # AMI ID for Amazon Linux AMI 2017.09.0 (HVM)
  ami = "ami-c5062ba0"
  instance_type = "t2.micro" # Free Tier
}
