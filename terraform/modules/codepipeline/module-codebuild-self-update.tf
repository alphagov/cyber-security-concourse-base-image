module "codebuild-self-update" {
  source                            = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild_terraform_apply?ref=codebuild-terraform-apply"
  codebuild_service_role_name       = var.codebuild_service_role_name
  deployment_account_id             = data.aws_caller_identity.current.account_id
  deployment_role_name              = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  terraform_directory               = "terraform/deployments/${data.aws_caller_identity.current.account_id}"
  codebuild_image                   = "gdscyber/cyber-security-concourse-base-image:latest"
}
