module "codebuild-dockerhub-build" {
  source = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_project_container_build_docker_hub?ref=codebuild_container"
  service_role_name   = var.codebuild_service_role_name
  image_name          = "cyber-security-concourse-base-image"
  image_tag           = "code_pipeline_test"
  build_context       = "."
  dockerfile          = "Dockerfile"
  docker_hub_username = jsondecode(data.aws_ssm_parameter.docker_hub_credentials.value).username
  docker_hub_password = jsondecode(data.aws_ssm_parameter.docker_hub_credentials.value).password
  pipeline_name       = var.pipeline_name
  environment         = var.environment
}

data "aws_ssm_parameter" "docker_hub_credentials" {
  name = var.docker_credentials_secret_name
}
