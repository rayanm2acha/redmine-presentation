terraform {
  backend "s3" {
    bucket         = "redmine-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}