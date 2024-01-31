terraform {
    backend "s3" {
        bucket = "vikramsamplebucket"
        key = "terraform/vikram-assessment/terraform.tfstate"
        region = "ca-central-1"
        dynamodb_table = "terraform_state_locking"
        encrypt = true
    }
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}