# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "8c6f9e0e-915e-4898-b190-8494072467b2"
  client_id       = "7cb89389-135d-463e-8b69-e8c97c297026"
  client_secret   = "UYASDGas5dfaghuy&*YGusysd"
  tenant_id       = "d017007d-9b9c-44cc-84d8-95533b70f026"
}

# Create a resource group
resource "azurerm_resource_group" "Azuregek-Networking" {
    name     = "AZUREGEK-NETWORKING"
    location = "West Europe"
}

# Create a virtual network in the web_servers resource group
resource "azurerm_virtual_network" "network" {
  name                = "Network-vNET"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  resource_group_name = "${azurerm_resource_group.Azuregek-Networking.name}"

  subnet {
    name           = "Firm1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "Firm2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "Firm3"
    address_prefix = "10.0.3.0/24"
  }
}
