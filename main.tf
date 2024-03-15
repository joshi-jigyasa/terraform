resource "aws_instance" "terra-1" {
  ami = var.ami-id
instance_type = var.instance_type
key_name = var.key_name
tags = {
    Name = "terra-1"
}
}