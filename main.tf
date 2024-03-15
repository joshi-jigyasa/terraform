#create cust vpc

resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block
  tags={
    Name = "my_vpc"
  }
}

#create IG and attach to vpc

resource "aws_internet_gateway" "my-ig1" {

    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "terra-ig1"
    }
  
}
#create SG
resource "aws_security_group" "traffic" {
  vpc_id = aws_vpc.my_vpc.id
  name = "Allow Traffic"

  ingress = [{
    description = ""
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
    self = false
    security_groups = []
    ipv6_cidr_blocks = []
    prefix_list_ids = []
  },
  {
    description = ""
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
    self = false
    security_groups = []
    ipv6_cidr_blocks=[]
    prefix_list_ids = []
  }]
  egress = [{
    description = ""
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0",]
    self = false
    security_groups = []
    ipv6_cidr_blocks = []
    prefix_list_ids = []
  }]
}
#create subnets

resource "aws_subnet" "my-subnet1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet1_cidrblock
    availability_zone = "ap-south-1a"
    tags = {
      Name = "terra-sub-1-pub"
      
    }
}

resource "aws_subnet" "my-subnet2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet2_cidrblock
    availability_zone = "ap-south-1b"
    tags = {
      Name = "terra-sub-2-pub"
    }
}

#create public route table and edit route attach to Internet gateway

resource "aws_route_table" "my-rt1" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "terra-rt1"
  }
route {
    cidr_block = var.destination_cidrblock
    gateway_id = aws_internet_gateway.my-ig1.id
}
 

}


#edit subnet association

resource "aws_route_table_association" "myrt11" {
  subnet_id = aws_subnet.my-subnet1.id
  route_table_id = aws_route_table.my-rt1.id
  
}
#create EIP
resource "aws_eip" "my-eip" {
  
}
#create NAT gateway 
resource "aws_nat_gateway" "my-nat" {
  allocation_id = aws_eip.my-eip.id
  subnet_id     = aws_subnet.my-subnet1.id

  tags = {
    Name = "my-NAT"
  }

 
}
#create private Route table and attach to nat gateway

resource "aws_route_table" "my-rt2" {
  
  vpc_id = aws_vpc.my_vpc.id
tags = {
  Name="pvt-Rt1"
}
route {

    cidr_block = var.destination_cidrblock
    gateway_id=aws_nat_gateway.my-nat.id
}
}

#edit subnet asssociation

resource "aws_route_table_association" "myrt2" {
  subnet_id = aws_subnet.my-subnet2.id
  route_table_id = aws_route_table.my-rt2.id
  
}


