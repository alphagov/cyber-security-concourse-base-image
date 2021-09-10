resource "aws_codepipeline" "cd-chrome-driver" {
  name     = var.pipeline_name
  role_arn = data.aws_iam_role.pipeline_role.arn
  tags     = merge(local.tags, { Name = "${var.pipeline_name}" })

  artifact_store {
    type     = "S3"
    location = data.aws_s3_bucket.artifact_store.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["git_base_image"]
      configuration = {
        ConnectionArn    = "arn:aws:codestar-connections:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:connection/${var.codestar_connection_id}"
        FullRepositoryId = "alphagov/cyber-security-concourse-base-image"
        BranchName       = "CE-256-migrate-pipeline"
      }
    }
  }


  stage {
    name = "Changes"

    action {
      name             = "GetChangedFiles"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["git_base_image"]
      output_artifacts = ["changed_files"]
      configuration = {
        ProjectName = module.codebuild-get-changed-file-list.project_name
      }
    }
  }

  stage {
    name = "Actions"

    action {
      name             = "GetActionsRequired"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["git_base_image", "changed_files"]
      output_artifacts = ["actions_required"]
      configuration = {
        PrimarySource = "git_base_image"
        ProjectName   = module.codebuild-get-actions-required.project_name
      }
    }
  }

  stage {
    name = "BuildDockerImages"

    action {
      name             = "BuildAndPushCdImage"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["git_base_image", "actions_required"]
      output_artifacts = []

      configuration = {
        PrimarySource        = "git_base_image"
        ProjectName          = module.codebuild-build-container-docker-hub-cd.project_name
        EnvironmentVariables = jsonencode([{ "name" : "CHECK_TRIGGER", "value" : 1 }, { "name" : "ACTION_NAME", "value" : "BuildAndPushCdImage" }])
      }
    }

    action {
      name             = "BuildAndPushConcourseImage"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["git_base_image", "actions_required"]
      output_artifacts = []

      configuration = {
        PrimarySource        = "git_base_image"
        ProjectName          = module.codebuild-build-container-docker-hub-concourse.project_name
        EnvironmentVariables = jsonencode([{ "name" : "CHECK_TRIGGER", "value" : 1 }, { "name" : "ACTION_NAME", "value" : "BuildAndPushConcourseImage" }])
      }
    }
  }

  stage {
    name = "Update"

    action {
      name             = "UpdatePipeline"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["git_base_image"]
      output_artifacts = ["terraform_output"]
      configuration = {
        ProjectName = module.codebuild-self-update.project_name
      }
    }
  }
}
