module "codebuild-build-container-ecr" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_build_container_ecr"
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_service_role_name = var.codebuild_service_role_name
  build_context               = "."
  dockerfile                  = "Dockerfile"
  ecr_image_repo_name         = "cyber-security-cd-base-image"
  docker_hub_username         = local.docker_hub_username
  docker_hub_password         = local.docker_hub_password
  pipeline_name               = var.pipeline_name
  environment                 = var.environment
}
