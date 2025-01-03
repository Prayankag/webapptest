# Configure the Azure provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.64.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id ="f936a180-7b93-4203-8faa-f376529bd4f8"
  client_id       ="a2d89136-b086-4755-9f98-af856c2d8c30"
  client_secret  = "QEt8Q~el5WQ8JWv56IsRMvM5mSJeMHsflwyEJbQ7"
  tenant_id      = "13085c86-4bcb-460a-a6f0-b373421c6323"
}


# Define the resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Define the Service Plan
resource "azurerm_service_plan" "example" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Define SKU attributes directly
  sku_name            = var.sku_size  # This should be the full SKU name, like "B1", "S1", etc.
  os_type             = var.os_type  # "Linux" or "Windows"
}

resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}


# Define the Web App
resource "azurerm_app_service" "example" {
  name                = "${var.web_app_name}-${random_string.unique.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.example.id

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"
  }
}