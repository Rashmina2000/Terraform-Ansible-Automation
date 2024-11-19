terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}
provider "aws" {
  region = "us-east-1"
  access_key = "<access-key>"
  secret_key = "<secret-access-key>"
}

resource "aws_key_pair" "aws-key" {
  key_name = "aws-key"
  public_key = file("/home/ubuntu-root/Downloads/keys/aws-key.pub")
}

output "instance_1_ip_addr" {
  value = aws_instance.instance_1.public_ip
}