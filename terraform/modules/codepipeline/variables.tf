variable "staging_account_id" {
  type        = string
  description = "Test AWS account ID"
}

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
}

variable "environment" {
  type    = string
  default = "test"
}

variable "pipeline_name" {
  type    = string
  default = "cd-container-images"
}
