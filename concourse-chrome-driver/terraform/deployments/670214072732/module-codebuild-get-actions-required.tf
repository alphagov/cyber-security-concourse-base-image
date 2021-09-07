module "codebuild-get-actions-required" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_get_actions_required"
  codebuild_service_role_name = var.codebuild_service_role_name
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_image             = var.codebuild_image
  pipeline_name               = var.pipeline_name
  stage_name                  = "actions"
  action_name                 = "get-actions-required"
  environment                 = var.environment
  output_artifact_path        = var.output_artifact_path
  artifact_bucket             = data.aws_s3_bucket.artifact_store.bucket
  action_triggers             = var.action_triggers
}
