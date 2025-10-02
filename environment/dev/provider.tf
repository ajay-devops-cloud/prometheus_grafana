terraform {
    # backend "azurerm" {
    #   resource_group_name = "rg-it"
    #   storage_account_name = "itsolution2"
    #   container_name = "nextlevelcontainer"
    #   key = "myt.tfstate"
    # }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.42.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
  subscription_id = "b2f35947-820e-42de-96c7-8905c7b6a259"
}