provider "aws" {
  access_key = "AKIAJEVSVNXDXA4YTTTA"
  secret_key = ""
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
}