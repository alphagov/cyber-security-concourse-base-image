module "codebuild-get-changed-file-list" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_get_changed_file_list"
  codebuild_service_role_name = var.codebuild_service_role_name
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_image             = "gdscyber/cyber-security-cd-base-image:latest"
  pipeline_name               = var.pipeline_name
  environment                 = var.environment
  github_pat                  = var.github_pat
  stage_name                  = "Changes"
  action_name                 = "GetChangedFiles"
  repo_name                   = "cyber-security-concourse-base-image"
  docker_hub_credentials      = var.docker_hub_credentials
  output_artifact_path        = "cd-images-pipeline/output-artifacts"
  artifact_bucket             = data.aws_s3_bucket.artifact_store.bucket
}