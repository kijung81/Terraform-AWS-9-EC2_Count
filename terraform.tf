terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # cloud {
  #   organization = "Golfzon"
  #   workspaces {
  #     name = "scenario_9_ec2Count"
  #   }
  # }
}

provider "aws" {
  region = "ap-northeast-2"
}