module "codepipeline-healthcheck" {
  source                         = "github.com/alphagov/cyber-security-shared-terraform-modules//codepipeline_healthcheck?ref=codepipeline-event-rule"
  pipeline_name                  = "concourse-cd-images"
  health_notification_topic_name = "health-monitoring-test" # Change before going into production
}
