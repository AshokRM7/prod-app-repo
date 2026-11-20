resource "aws_iam_role" "codepipeline_service" {
  name = "AWSCodePipelineServiceRole-ap-south-1-production-app-pipeline"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CodePipelineTrustPolicy"
        Effect = "Allow"

        Principal = {
          Service = "codepipeline.amazonaws.com"
        }

        Action = "sts:AssumeRole"

        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "699061129530"
          }
        }
      }
    ]
  })

  tags = {
    project = "learning"
  }
}
resource "aws_iam_role_policy" "codepipeline_verify_build" {
  name = "CodePipelineVerifyBuildPolicy"
  role = aws_iam_role.codepipeline_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ]
        Resource = aws_codebuild_project.verify.arn
      }
    ]
  })
}
resource "aws_iam_role_policy" "codepipeline_ecs_deploy" {
  name = "CodePipelineECSDeployPolicy"
  role = aws_iam_role.codepipeline_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "TaskDefinitionPermissions"
        Effect = "Allow"
        Action = [
          "ecs:DescribeTaskDefinition",
          "ecs:RegisterTaskDefinition"
        ]
        Resource = "*"
      },
      {
        Sid = "ECSServicePermissions"
        Effect = "Allow"
        Action = [
          "ecs:DescribeServices",
          "ecs:UpdateService"
        ]
        Resource = "*"
      },
      {
        Sid    = "PassEcsExecutionRole"
        Effect = "Allow"
        Action = "iam:PassRole"
        Resource = aws_iam_role.ecs_task_execution.arn

        Condition = {
          StringEquals = {
            "iam:PassedToService" = [
              "ecs.amazonaws.com",
              "ecs-tasks.amazonaws.com"
            ]
          }
        }
      }
    ]
  })
}