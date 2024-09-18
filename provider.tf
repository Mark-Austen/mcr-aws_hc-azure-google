terraform {
  required_providers {
    megaport = {
      source  = "megaport/megaport"
      version = "1.1.8"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
    google = {
      source = "hashicorp/google"
      version = "6.2.0"
    }
  }
}

provider "megaport" {
  access_key            = "<access_key>"
  secret_key            = "<secret_key>"
  accept_purchase_terms = true
  environment           = "production"
}

provider "aws" {
  region = var.aws_region_1
  access_key = "<access_key>"
  secret_key = "<secret_key>"
}

provider "azurerm" {
  features {} 
}

provider "google" {
  project = "megaport-customer-project"
  region  = "australia-southeast1"
}
