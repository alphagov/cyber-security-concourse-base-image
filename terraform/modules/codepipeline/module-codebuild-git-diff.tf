module "codebuild-git-diff" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_git_diff?ref=ce-179"
  codebuild_service_role_name = var.codebuild_service_role_name
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_image             = "gdscyber/cyber-security-concourse-base-image:latest"
  pipeline_name               = var.pipeline_name
  environment                 = var.environment
  github_pat                  = var.github_pat
  repo_name                   = "cyber-security-concourse-base-image"
  output_filename             = "changed_files.json"
  docker_hub_credentials      = var.docker_hub_credentials
}