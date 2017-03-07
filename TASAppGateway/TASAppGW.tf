# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "8c6f9e0e-915e-4898-b190-8494072467b2"
  client_id       = "7cb89389-135d-463e-8b69-e8c97c297026"
  client_secret   = "UYASDGas5dfaghuy&*YGusysd"
  tenant_id       = "d017007d-9b9c-44cc-84d8-95533b70f026"
}

########### Storage account with application gateway baseline template
resource "azurerm_resource_group" "terraform-applicationGateway" {
    name = "terraform-applicationGateway"
    location = "West Europe"
}
########### Diagnostics storage account in terraform resourcegroup
resource "azurerm_storage_account" "terraform-applicationGateway" {
    name = "terraformdiagnostics01"
    resource_group_name = "${azurerm_resource_group.terraform-applicationGateway.name}"
    location = "westeurope"
    account_type = "Standard_LRS"

    tags {
        environment = "staging"
    }
}

resource "azurerm_storage_account" "templatestorage" {
    name = "terraformtemplates01"
    resource_group_name = "${azurerm_resource_group.terraform-applicationGateway.name}"
    location = "westeurope"
    account_type = "Standard_LRS"

    tags {
        environment = "staging"
    }
}

resource "azurerm_storage_container" "templatestorage" {
    name = "conf"
    resource_group_name = "${azurerm_resource_group.terraform-applicationGateway.name}"
    storage_account_name = "${azurerm_storage_account.templatestorage.name}"
    container_access_type = "private"
}

resource "azurerm_storage_blob" "templatestorage" {
    name = "apgbaseline.json"

    resource_group_name = "${azurerm_resource_group.terraform-applicationGateway.name}"
    storage_account_name = "${azurerm_storage_account.templatestorage.name}"
    storage_container_name = "${azurerm_storage_container.templatestorage.name}"
    source = "conf/apgbaseline.json"

    type = "block"
    size = 5120
}

