module "codebuild-get-actions-required" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_get_actions_required"
  codebuild_service_role_name = var.codebuild_service_role_name
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_image             = var.codebuild_image
  pipeline_name               = var.pipeline_name
  stage_name                  = "Actions"
  action_name                 = "GetActionsRequired"
  environment                 = var.environment
  output_artifact_path        = var.output_artifact_path
  action_triggers_json        = var.action_triggers_json
  changed_files_json          = var.changed_files_json
}
