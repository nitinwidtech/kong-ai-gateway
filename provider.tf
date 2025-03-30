terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.50.0" # Ensure it's the latest version that supports OpenAI
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
}
