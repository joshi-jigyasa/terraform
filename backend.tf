
terraform {
  backend "s3" {
    bucket = "jiggs-terra1"
    key    = "terraform.tfstate"
    region = "ap-south-1"


  }
}
