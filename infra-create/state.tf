terraform {
  backend "s3" {
    bucket = "d80-terraform-ppk"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}