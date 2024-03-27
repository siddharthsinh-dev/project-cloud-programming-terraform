# Terraform Configuration File
# This file defines the Terraform Configuration for AWS

# Specify the required version of Terraform
terraform {
  required_version = ">=1.0.11"
  
  # Define the required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.60.0"
    }
  }
}

