module "codebuild-dockerhub-build" {
  source              = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_project_container_build_docker_hub?ref=codebuild_container"
  service_role_name   = var.codebuild_service_role_name
  docker_hub_repo     = "gdscyber/cyber-security-cd-base-image"
  build_context       = "."
  dockerfile          = "Dockerfile"
  docker_hub_username = local.docker_hub_username
  docker_hub_password = local.docker_hub_password
  pipeline_name       = var.pipeline_name
  environment         = var.environment
}