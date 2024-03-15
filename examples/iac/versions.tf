terraform {
  required_version = ">= 1.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 4.67.0"
        }
        artifactory = {
            source = "registry.terraform.io/jfrog/artifactory"
            version = "2.6.17"
        }
    }
}