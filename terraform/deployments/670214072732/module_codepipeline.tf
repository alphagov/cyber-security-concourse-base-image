module "codepipeline" {
  source                      = "../../modules/codepipeline"
  codestar_connection_id      = "51c5be90-8c8f-4d32-8be4-18b8f05c802c"
  staging_account_id          = "103495720024"
  codebuild_service_role_name = "CodePipelineExecutionRole"
}
