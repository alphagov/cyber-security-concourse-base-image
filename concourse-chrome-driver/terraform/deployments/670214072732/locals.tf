locals {
  tags = {
    Service       = "cd-chrome-driver"
    Environment   = var.environment
    SvcOwner      = "Cyber"
    DeployedUsing = "Terraform_v12"
    SvcCodeURL    = "https://github.com/alphagov/cyber-security-concourse-base-image"
  }

  docker_hub_username = jsondecode(data.aws_secretsmanager_secret_version.dockerhub_creds.secret_string)["username"]
  docker_hub_password = jsondecode(data.aws_secretsmanager_secret_version.dockerhub_creds.secret_string)["password"]
}
