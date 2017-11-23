# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "example_fullstack_conf" {
  # AMI ID for Amazon Linux AMI 2017.09.1 (HVM), SSD Volume Type
  ami = "ami-55ef662f"
  instance_type = "t2.micro" # Free Tier

  #tags {
  #    Name = "terraform-demo-fullstack-conf"
  #}
}


