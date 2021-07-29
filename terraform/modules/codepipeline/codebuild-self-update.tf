resource "aws_codebuild_project" "code_pipeline_self_update" {
  name        = "code_pipeline_self_update"
  description = "Update the pipeline"

  service_role = data.aws_iam_role.pipeline_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    #environment_variable {
    #  name  = "DOCKERHUB_USERNAME"
    #  value = "docker_hub_credentials:username"
    #  type = "SECRETS_MANAGER"
    #}

    #environment_variable {
    #  name  = "DOCKERHUB_PASSWORD"
    #  value = "docker_hub_credentials:password"
    #  type = "SECRETS_MANAGER"
    #}

    #environment_variable {
    #  name  = "AWS_ACCOUNT_ID"
    #  value = data.aws_caller_identity.current.account_id
    #}

    #  environment_variable {
    #  name  = "AWS_DEFAULT_REGION"
    #  value = data.aws_region.current.name
    #}

    #environment_variable {
    #  name  = "DOCKERHUB_CONTEXT"
    #  value = "./docker/keycloak"
    #}

    #environment_variable {
    #  name  = "DOCKERHUB_DOCKERFILE"
    #  value = "docker/keycloak/Dockerfile"
    #}

    #environment_variable {
    #  name  = "DOCKERHUB_REPO"
    #  value = "gdscyber/ah-keycloak-test"
    #}

    #environment_variable {
    #  name  = "DOCKERHUB_IMAGE_TAG"
    #  value = "latest"
    #}
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/codebuild-self-update.yml")
  }
}
