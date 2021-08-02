variable "staging_account_id" {
  type        = string
  description = "Test AWS account ID"
}

variable "codestar_connection_id" {
  type = string
}

variable "codebuild_service_role_name" {
  description = "the role code build uses to access other AWS services"
  type = string
}
