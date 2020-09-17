provider "aws" {
  version    = "~> 3.6.0"
}

terraform {
  backend "s3" {
  }
}
