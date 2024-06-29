terraform {
  backend "s3" {
    bucket         = "telus-assesment-terraform-state-backend"
    key            = "terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraform_state"
  }
}