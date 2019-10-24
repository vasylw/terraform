provider "aws" {
  shared_credentials_file = "/var/lib/jenkins/workspace/.aws/credentials"
  region     = var.region
  profile = "default"
}

resource "aws_instance" "example" {
  ami           = var.amis[var.region]
  instance_type = "t2.micro"

provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}
