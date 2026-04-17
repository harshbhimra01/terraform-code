terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "ball" {
  name     = "harsh-resources"
  location = "south india"
}

resource "azurerm_storage_account" "implicit" {
  name                     = "harshchetansujeet"
  resource_group_name      = azurerm_resource_group.ball.name
  location                 = azurerm_resource_group.ball.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_account" "explicit" {
  depends_on               = [azurerm_resource_group.ball]
  name                     = "harshchetansujeet1"
  resource_group_name      = "harsh-resources"
  location                 = "south india"
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "name" {
  depends_on = [ azurerm_storage_account.implicit ]
  name = "container"
  storage_account_id = "harshchetansujeet"
  container_access_type = "private"
}