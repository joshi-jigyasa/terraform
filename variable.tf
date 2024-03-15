variable "cidr_block" {
description = "passing cidr of vpc"
type = string
    default = ""
  
}

variable "subnet1_cidrblock" {
  default = ""
}

variable "subnet2_cidrblock" {
  default = ""
}

variable "destination_cidrblock" {
  default = ""
}

variable "ami-id" {
  default = ""
}

variable "instance-type" {
    default = ""
  
}

variable "keypair" {
  default = ""
}