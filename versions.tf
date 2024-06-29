terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.56.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}