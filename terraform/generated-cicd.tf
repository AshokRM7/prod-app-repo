# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_codebuild_project" "app_build" {
  badge_enabled          = false
  build_timeout          = 20
  encryption_key         = "arn:aws:kms:ap-south-1:699061129530:alias/aws/s3"
  name                   = "production-app-build"
  project_visibility     = "PRIVATE"
  queued_timeout         = 60
  resource_access_role   = null
  service_role           = "arn:aws:iam::699061129530:role/service-role/codebuild-production-app-build-service-role"
  source_version         = "main"
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
    privileged_mode             = true
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
    buildspec           = "buildspec.yml"
    git_clone_depth     = 1
    insecure_ssl        = false
    location            = "https://github.com/AshokRM7/prod-app-repo"
    report_build_status = false
    type                = "GITHUB"
    git_submodules_config {
      fetch_submodules = false
    }
  }
}
