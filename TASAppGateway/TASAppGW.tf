# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "8c6f9e0e-915e-4898-b190-8494072467b2"
  client_id       = "7cb89389-135d-463e-8b69-e8c97c297026"
  client_secret   = "UYASDGas5dfaghuy&*YGusysd"
  tenant_id       = "d017007d-9b9c-44cc-84d8-95533b70f026"
}

resource "azurerm_resource_group" "terraform-appGW" {
    name = "terraform-appGW"
    location = "West Europe"
}

resource "azurerm_resource_group" "main-network" {
    name = "main-networking"
    location = "West Europe"
}

resource "azurerm_virtual_network" "main-network" {
    name = "main-network"
    address_space = ["10.0.0.0/16"]
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.main-network.name}"
}

resource "azurerm_subnet" "main-network" {
    name = "Subnet1"
    resource_group_name = "${azurerm_resource_group.main-network.name}"
    virtual_network_name = "${azurerm_virtual_network.main-network.name}"
    address_prefix = "10.0.10.0/24"
}

resource "azurerm_storage_account" "terraform-appGW" {
    name = "jacobterraformdiagnostics01"
    resource_group_name = "${azurerm_resource_group.terraform-appGW.name}"
    location = "westeurope"
    account_type = "Standard_LRS"

    tags {
        environment = "staging"
    }
}



 resource "azurerm_template_deployment" "test" {
    name = "acctesttemplate-01"
    resource_group_name = "${azurerm_resource_group.test.name}"
    template_body = <<DEPLOY
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageAccountType": {
      "type": "string",
      "defaultValue": "Standard_LRS",
      "allowedValues": [
        "Standard_LRS",
        "Standard_GRS",
        "Standard_ZRS"
      ],
      "metadata": {
        "description": "Storage Account type"
      }
    }
  },
  "variables": {
    "location": "[resourceGroup().location]",
    "storageAccountName": "[concat(uniquestring(resourceGroup().id), 'storage')]",
    "publicIPAddressName": "[concat('myPublicIp', uniquestring(resourceGroup().id))]",
    "publicIPAddressType": "Dynamic",
    "apiVersion": "2015-06-15",
    "dnsLabelPrefix": "terraform-acctest"
  },
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "name": "[variables('storageAccountName')]",
      "apiVersion": "[variables('apiVersion')]",
      "location": "[variables('location')]",
      "properties": {
        "accountType": "[parameters('storageAccountType')]"
      }
    },
    {
      "type": "Microsoft.Network/publicIPAddresses",
      "apiVersion": "[variables('apiVersion')]",
      "name": "[variables('publicIPAddressName')]",
      "location": "[variables('location')]",
      "properties": {
        "publicIPAllocationMethod": "[variables('publicIPAddressType')]",
        "dnsSettings": {
          "domainNameLabel": "[variables('dnsLabelPrefix')]"
        }
      }
    }
  ]
}
DEPLOY
    deployment_mode = "Complete"
  }
