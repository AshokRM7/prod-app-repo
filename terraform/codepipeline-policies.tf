resource "aws_iam_policy" "codepipeline_artifact_s3" {
  name        = "AWSCodePipelineServiceRole-ap-south-1-production-app-pipeline"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodePipeline for service role"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowS3BucketAccess"
        Effect = "Allow"
        Action = [
          "s3:GetBucketVersioning",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::codepipeline-ap-south-1-a52eb8beec0b-4b85-8119-c930e9fe1e41"
        ]
        Condition = {
          StringEquals = {
            "aws:ResourceAccount" = "699061129530"
          }
        }
      },
      {
        Sid    = "AllowS3ObjectAccess"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]
        Resource = [
          "arn:aws:s3:::codepipeline-ap-south-1-a52eb8beec0b-4b85-8119-c930e9fe1e41/*"
        ]
        Condition = {
          StringEquals = {
            "aws:ResourceAccount" = "699061129530"
          }
        }
      }
    ]
  })
}
resource "aws_iam_policy" "codepipeline_codebuild" {
  name        = "CodePipeline-CodeBuild-ap-south-1-production-app-pipeline"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodePipeline for CodeBuild Action"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuildBatches",
          "codebuild:StartBuildBatch"
        ]
        Resource = [
          "arn:aws:codebuild:*:699061129530:project/production-app-build"
        ]
      }
    ]
  })
}
resource "aws_iam_policy" "codepipeline_codeconnections" {
  name        = "CodePipeline-CodeConnections-ap-south-1-production-app-pipeline"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodePipeline for CodeConnections Action"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codeconnections:UseConnection",
          "codestar-connections:UseConnection"
        ]
        Resource = [
          "arn:aws:codestar-connections:*:699061129530:connection/<ACTUAL_CONNECTION_ID>",
          "arn:aws:codeconnections:*:699061129530:connection/<ACTUAL_CONNECTION_ID>"
        ]
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "codepipeline_artifact_s3" {
  role       = aws_iam_role.codepipeline_service.name
  policy_arn = aws_iam_policy.codepipeline_artifact_s3.arn
}
resource "aws_iam_role_policy_attachment" "codepipeline_codebuild" {
  role       = aws_iam_role.codepipeline_service.name
  policy_arn = aws_iam_policy.codepipeline_codebuild.arn
}
resource "aws_iam_role_policy_attachment" "codepipeline_codeconnections" {
  role       = aws_iam_role.codepipeline_service.name
  policy_arn = aws_iam_policy.codepipeline_codeconnections.arn
}