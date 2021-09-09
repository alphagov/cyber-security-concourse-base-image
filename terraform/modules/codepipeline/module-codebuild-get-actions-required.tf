module "codebuild-get-actions-required" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_get_actions_required"
  codebuild_service_role_name = var.codebuild_service_role_name
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_image             = "gdscyber/cyber-security-cd-base-image:latest"
  pipeline_name               = var.pipeline_name
  stage_name                  = "Actions"
  action_name                 = "GetActionsRequired"
  environment                 = var.environment
  action_triggers_json        = "$CODEBUILD_SRC_DIR/terraform/modules/codepipeline/action_triggers.json"
  changed_files_json          = "$CODEBUILD_SRC_DIR_changed_files/changed_files.json"
  output_artifact_path        = "actions_required.json"
}
