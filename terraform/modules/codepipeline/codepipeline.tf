resource "aws_codepipeline" "cd-container-images" {
  name     = "${var.pipeline_name}-${var.environment}"
  role_arn = data.aws_iam_role.pipeline_role.arn
  tags     = merge(local.tags, { Name = "${var.pipeline_name}-${var.environment}" })

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
        BranchName       = "cd-images-pipeline"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "UpdatePipeline"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["git_base_image"]
      output_artifacts = []

      configuration = {
        ProjectName = module.codebuild-self-update.project_name
      }
    }
  }

  stage {
    name = "CheckGitDiff"

    action {
      name             = "CheckGitDiff"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["git_base_image"]
      output_artifacts = []

      configuration = {
        ProjectName = module.codebuild-git-diff.project_name
      }
    }
  }

  stage {
    name = "BuildAndPushCdImage"

    action {
      name             = "DockerHub"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["git_base_image"]
      output_artifacts = []

      configuration = {
        ProjectName = module.codebuild-dockerhub-build.project_name
      }
    }

    action {
      name             = "Ecr"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["git_base_image"]
      output_artifacts = []

      configuration = {
        ProjectName = module.codebuild-ecr.project_name
      }
    }
  }
}