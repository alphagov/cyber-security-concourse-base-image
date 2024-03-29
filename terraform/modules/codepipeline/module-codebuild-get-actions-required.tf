module "codebuild-get-actions-required" {
  source                      = "github.com/alphagov/cyber-security-shared-terraform-modules//codebuild/codebuild_get_actions_required"
  codebuild_service_role_name = var.codebuild_service_role_name
  deployment_account_id       = data.aws_caller_identity.current.account_id
  deployment_role_name        = "CodePipelineDeployerRole_${data.aws_caller_identity.current.account_id}"
  codebuild_image             = "gdscyber/cyber-security-cd-base-image:latest"
  pipeline_name               = var.pipeline_name
  docker_hub_credentials      = var.docker_hub_credentials
  stage_name                  = "Actions"
  action_name                 = "GetActionsRequired"
  environment                 = var.environment
  changed_files_json          = "/changed_files.json"
  output_artifact_path        = "actions_required.json"
  action_triggers_json        = "/terraform/modules/codepipeline/action_triggers.json"
}
