locals {
  tags = {
    Service       = "cd-images-pipeline"
    Environment   = var.environment
    SvcOwner      = "Cyber"
    DeployedUsing = "Terraform_v12"
    SvcCodeURL    = "https://github.com/alphagov/cyber-security-concourse-base-image"
  }
}
