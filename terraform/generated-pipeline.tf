# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_codepipeline" "app_pipeline" {
  execution_mode = "QUEUED"
  name           = "production-app-pipeline"
  pipeline_type  = "V2"
  role_arn       = "arn:aws:iam::699061129530:role/service-role/AWSCodePipelineServiceRole-ap-south-1-production-app-pipeline"
  tags           = {}
  tags_all = {
    project = "learning"
  }
  artifact_store {
    location = "codepipeline-ap-south-1-a52eb8beec0b-4b85-8119-c930e9fe1e41"
    region   = null
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      category = "Source"
      configuration = {
        BranchName           = "main"
        ConnectionArn        = "arn:aws:codeconnections:ap-south-1:699061129530:connection/a83c37fd-817b-4cde-a0d0-ce4f2c388590"
        DetectChanges        = "true"
        FullRepositoryId     = "AshokRM7/prod-app-repo"
        OutputArtifactFormat = "CODE_ZIP"
      }
      input_artifacts    = []
      name               = "Source"
      namespace          = "SourceVariables"
      output_artifacts   = ["SourceArtifact"]
      owner              = "AWS"
      provider           = "CodeStarSourceConnection"
      region             = "ap-south-1"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
  }
  stage {
    name = "Build"
    action {
      category = "Build"
      configuration = {
        ProjectName = "production-app-build"
      }
      input_artifacts    = ["SourceArtifact"]
      name               = "Build"
      namespace          = "BuildVariables"
      output_artifacts   = ["BuildArtifact"]
      owner              = "AWS"
      provider           = "CodeBuild"
      region             = "ap-south-1"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
  }
  stage {
    name = "Approval"
    action {
      category = "Approval"
      configuration = {
        CustomData = "Approve deployment to production ECS services"
      }
      input_artifacts    = []
      name               = "ProductionApproval"
      namespace          = null
      output_artifacts   = []
      owner              = "AWS"
      provider           = "Manual"
      region             = "ap-south-1"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
  }
  stage {
    name = "DeployBackend"
    action {
      category = "Deploy"
      configuration = {
        ClusterName = "production-app-cluster"
        FileName    = "imagedefinitions-backend.json"
        ServiceName = "production-app-backend-service"
      }
      input_artifacts    = ["BuildArtifact"]
      name               = "DeployBackend"
      namespace          = null
      output_artifacts   = []
      owner              = "AWS"
      provider           = "ECS"
      region             = "ap-south-1"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
  }
  stage {
    name = "DeployFrontend"
    action {
      category = "Deploy"
      configuration = {
        ClusterName = "production-app-cluster"
        FileName    = "imagedefinitions-frontend.json"
        ServiceName = "production-app-frontend-service"
      }
      input_artifacts    = ["BuildArtifact"]
      name               = "DeployFrontend"
      namespace          = null
      output_artifacts   = []
      owner              = "AWS"
      provider           = "ECS"
      region             = "ap-south-1"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
  }
  stage {
    name = "Verify"
    action {
      category = "Build"
      configuration = {
        ProjectName = "production-app-verify"
      }
      input_artifacts    = ["BuildArtifact"]
      name               = "Verify"
      namespace          = null
      output_artifacts   = []
      owner              = "AWS"
      provider           = "CodeBuild"
      region             = "ap-south-1"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
  }
}
