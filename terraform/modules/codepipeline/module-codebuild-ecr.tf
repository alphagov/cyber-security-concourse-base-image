module "codebuild-ecr" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_ECR_push?ref=codebuild-ecs"
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_service_role_name = var.codebuild_service_role_name
  ecr_context                 = "."
  ecr_dockerfile              = "Dockerfile"
  ecr_image_repo_name         = "cyber-security-cd-base-image"
  pipeline_name               = var.pipeline_name
  environment                 = var.environment
}
