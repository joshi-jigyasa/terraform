# create ec2 inst for cust-vpc

resource "aws_instance" "my-ec2" {
  
  ami = var.ami-id
  instance_type = var.instance-type
  key_name = var.keypair
associate_public_ip_address = true
  subnet_id = aws_subnet.my-subnet1.id

  vpc_security_group_ids = [aws_security_group.traffic.id]
  tags = {
    Name = "terra-ec21"

  }


}