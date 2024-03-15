provider "aws" {

  region = var.aws_region

  default_tags {
    tags = {
      Environment    = "main"
      Owner          = "Singularbit Labs"
      Project        = "Singularbit Labs API"
      DeploymentType = "Terraform"
      Developers     = "Pedro"
    }
  }
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}
