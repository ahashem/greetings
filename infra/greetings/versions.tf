terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }

  }
}
