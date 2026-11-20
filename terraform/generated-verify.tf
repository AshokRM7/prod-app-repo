# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_codebuild_project" "verify" {
  badge_enabled          = false
  build_timeout          = 60
  encryption_key         = "arn:aws:kms:ap-south-1:699061129530:alias/aws/s3"
  name                   = "production-app-verify"
  project_visibility     = "PRIVATE"
  queued_timeout         = 120
  resource_access_role   = null
  service_role           = "arn:aws:iam::699061129530:role/service-role/codebuild-production-app-verify-service-role"
  source_version         = null
  tags                   = {}
  tags_all = {
    project = "learning"
  }
  artifacts {
    artifact_identifier    = null
    bucket_owner_access    = null
    encryption_disabled    = false
    location               = null
    name                   = null
    namespace_type         = null
    override_artifact_name = false
    packaging              = null
    path                   = null
    type                   = "NO_ARTIFACTS"
  }
  cache {
    location = null
    modes    = []
    type     = "NO_CACHE"
  }
  environment {
    certificate                 = null
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:8.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
    type                        = "LINUX_CONTAINER"
  }
  logs_config {
    cloudwatch_logs {
      group_name  = null
      status      = "ENABLED"
      stream_name = null
    }
    s3_logs {
      bucket_owner_access = null
      encryption_disabled = false
      location            = null
      status              = "DISABLED"
    }
  }
  source {
    buildspec           = "version: 0.2\n\nphases:\n  build:\n    commands:\n       - curl --fail --retry 5 --retry-delay 10 http://production-app-alb-1917539745.ap-south-1.elb.amazonaws.com/api/v1/health && curl --fail --retry 5 --retry-delay 10 http://production-app-alb-1917539745.ap-south-1.elb.amazonaws.com/   http://production-app-alb-1917539745.ap-south-1.elb.amazonaws.com/\n"
    git_clone_depth     = 1
    insecure_ssl        = false
    location            = null
    report_build_status = false
    type                = "NO_SOURCE"
  }
}
