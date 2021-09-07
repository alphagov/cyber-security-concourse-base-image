variable "codestar_connection_id" {
  type    = string
  default = "51c5be90-8c8f-4d32-8be4-18b8f05c802c"
}

variable "codebuild_service_role_name" {
  description = "the role code build uses to access other AWS services"
  type        = string
  default     = "CodePipelineExecutionRole"
}

variable "docker_hub_repo" {
  description = "Docker Hub repository"
  type        = string
  default     = ""
}

variable "docker_hub_credentials" {
  description = "Name of the secret in SSM that stores the Docker Hub credentials"
  type        = string
  default     = "docker_hub_credentials"
}

variable "stage_name" {
  description = "The name of the pipeline stage"
  type        = string
  default     = ""
}

variable "action_name" {
  description = "The name of the pipeline stage action"
  type        = string
  default     = ""
}

variable "dockerfile" {
  description = "Path to the dockerfile"
  type        = string
  default     = "concourse-chrome-driver/Dockerfile"
}

variable "codebuild_image" {
  default = "gdscyber/cyber-security-cd-base-image:latest"
}

variable "build_context" {
  description = "Path to the folder to run docker build from"
  type        = string
  default     = "concourse-chrome-driver/"
}

variable "output_artifact_path" {
  description = "the S3 path to store the output atrifact"
  type        = string
  default     = "cd-chrome-driver/output-artifacts"
}

variable "action_triggers" {
  description = "the path to the action_triggers.json file in your repo, relative to the root of the repo."
  type        = string
  default     = "/terraform/modules/codepipeline/action_triggers.json"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "pipeline_name" {
  type    = string
  default = "cd-chrome-driver"
}

variable "github_pat" {
  description = "the github pat token to authorise access to the repo. "
  type        = string
  default     = "/github/pat"
}

variable "repo_name" {
  description = "The repository on Github"
  type        = string
  default     = "cyber-security-concourse-base-image"
}
