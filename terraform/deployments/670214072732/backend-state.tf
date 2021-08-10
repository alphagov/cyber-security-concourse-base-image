terraform {
  backend "s3" {
    bucket  = "gds-security-terraform"
    key     = "terraform/state/account/670214072732/service/cd-images-pipeline.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
