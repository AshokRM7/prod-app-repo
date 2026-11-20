resource "aws_iam_role" "codebuild_app" {
  name = "codebuild-production-app-build-service-role"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "codebuild.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    project = "learning"
  }
}
resource "aws_iam_role" "codebuild_verify" {
  name = "codebuild-production-app-verify-service-role"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "codebuild.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    project = "learning"
  }
}
resource "aws_iam_role_policy" "codebuild_ecr_push" {
  name = "CodeBuildECRPushPolicy"
  role = aws_iam_role.codebuild_app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = [
          "arn:aws:ecr:ap-south-1:699061129530:repository/production-app-backend",
          "arn:aws:ecr:ap-south-1:699061129530:repository/production-app-frontend"
        ]
      }
    ]
  })
}
resource "aws_iam_policy" "codebuild_base" {
  name = "CodeBuildBasePolicy-production-app-build-ap-south-1"
  path = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:ap-south-1:699061129530:log-group:/aws/codebuild/production-app-build",
          "arn:aws:logs:ap-south-1:699061129530:log-group:/aws/codebuild/production-app-build:*"
        ]
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
      },
      {
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::codepipeline-ap-south-1-*"
        ]
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "codebuild:CreateReportGroup",
          "codebuild:CreateReport",
          "codebuild:UpdateReport",
          "codebuild:BatchPutTestCases",
          "codebuild:BatchPutCodeCoverages"
        ]
        Resource = [
          "arn:aws:codebuild:ap-south-1:699061129530:report-group/production-app-build-*"
        ]
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "codebuild_base" {
  role       = aws_iam_role.codebuild_app.name
  policy_arn = aws_iam_policy.codebuild_base.arn
}
resource "aws_iam_policy" "codebuild_codeconnections" {
  name = "CodeBuildCodeConnectionsSourceCredentialsPolicy-production-app-build-ap-south-1-699061129530"
  path = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codestar-connections:GetConnectionToken",
          "codestar-connections:GetConnection",
          "codeconnections:GetConnectionToken",
          "codeconnections:GetConnection",
          "codeconnections:UseConnection"
        ]
        Resource = [
          "arn:aws:codestar-connections:ap-south-1:699061129530:connection/<CONNECTION_ID>",
          "arn:aws:codeconnections:ap-south-1:699061129530:connection/<CONNECTION_ID>"
        ]
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "codebuild_codeconnections" {
  role       = aws_iam_role.codebuild_app.name
  policy_arn = aws_iam_policy.codebuild_codeconnections.arn
}