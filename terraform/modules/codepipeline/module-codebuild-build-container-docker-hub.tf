module "codebuild-build-container-docker-hub" {
  source              = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_build_container_docker_hub"
  service_role_name   = var.codebuild_service_role_name
  docker_hub_repo     = "gdscyber/cyber-security-cd-base-image"
  build_context       = "."
  dockerfile          = "Dockerfile"
  stage_name          = "BuildAndPushCdImage"
  action_name         = "DockerHub"
  docker_hub_username = local.docker_hub_username
  docker_hub_password = local.docker_hub_password
  pipeline_name       = var.pipeline_name
  environment         = var.environment
  tags                = local.tags
}
