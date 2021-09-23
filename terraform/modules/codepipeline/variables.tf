variable "codestar_connection_id" {
  type = string
}

variable "codebuild_service_role_name" {
  description = "the role code build uses to access other AWS services"
  type        = string
}

variable "docker_hub_credentials" {
  description = "Name of the secret in SSM that stores the Docker Hub credentials"
  type        = string
  default     = "docker_hub_credentials"
}

variable "environment" {
  type    = string
  default = "test"
}

variable "pipeline_name" {
  type    = string
  default = "cd-base-images"
}

variable "github_pat" {
  description = "the github pat token to authorise access to the repo. "
  type        = string
}
