resource "aws_codeconnections_connection" "github" {
  name          = "Github"
  provider_type = "GitHub"

  tags = {
    project = "learning"
  }
}