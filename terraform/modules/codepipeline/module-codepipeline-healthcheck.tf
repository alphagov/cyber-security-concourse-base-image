module "codepipeline-healthcheck" {
  source                         = "github.com/alphagov/cyber-security-shared-terraform-modules//codepipeline_healthcheck"
  pipeline_name                  = "${var.pipeline_name}-${var.environment}"
  health_notification_topic_name = "cloudwatch_event_forwarder"
}
