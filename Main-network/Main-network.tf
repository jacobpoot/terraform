# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "8c6f9e0e-915e-4898-b190-8494072467b2"
  client_id       = "7cb89389-135d-463e-8b69-e8c97c297026"
  client_secret   = "UYASDGas5dfaghuy&*YGusysd"
  tenant_id       = "d017007d-9b9c-44cc-84d8-95533b70f026"
}

resource "azurerm_resource_group" "main-networking" {
    name = "main-networking"
    location = "West Europe"
}

resource "azurerm_virtual_network" "main-networking" {
    name = "terraform-vnet"
    address_space = ["10.0.0.0/16"]
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.main-networking.name}"
}

resource "azurerm_subnet" "main-networking" {
    name = "terraform-subnet1"
    resource_group_name = "${azurerm_resource_group.main-networking.name}"
    virtual_network_name = "${azurerm_virtual_network.main-networking.name}"
    address_prefix = "10.0.1.0/24"
}

resource "azurerm_subnet" "test2" {
    name = "terraform-subnet2"
    resource_group_name = "${azurerm_resource_group.main-networking.name}"
    virtual_network_name = "${azurerm_virtual_network.main-networking.name}"
    address_prefix = "10.0.2.0/24"
}


