module "codebuild-build-container-docker-hub-cd" {
  source              = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_build_container_docker_hub"
  stage_name          = "codepipeline-docker-image"
  action_name         = "build-and-push-cd-image"
  service_role_name   = var.codebuild_service_role_name
  docker_hub_repo     = "gdscyber/cd-chrome-driver"
  build_context       = var.build_context
  dockerfile          = var.dockerfile
  docker_hub_username = local.docker_hub_username
  docker_hub_password = local.docker_hub_password
  pipeline_name       = var.pipeline_name
  environment         = var.environment
}

module "codebuild-build-container-docker-hub-concourse" {
  source              = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_build_container_docker_hub"
  service_role_name   = var.codebuild_service_role_name
  docker_hub_repo     = "gdscyber/concourse-chrome-driver"
  stage_name          = "concourse-docker-image"
  action_name         = "build-and-push-concourse-image"
  build_context       = var.build_context
  dockerfile          = var.dockerfile
  docker_hub_username = local.docker_hub_username
  docker_hub_password = local.docker_hub_password
  pipeline_name       = var.pipeline_name
  environment         = var.environment
}
