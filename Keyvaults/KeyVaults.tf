# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "8c6f9e0e-915e-4898-b190-8494072467b2"
  client_id       = "7cb89389-135d-463e-8b69-e8c97c297026"
  client_secret   = "UYASDGas5dfaghuy&*YGusysd"
  tenant_id       = "d017007d-9b9c-44cc-84d8-95533b70f026"
}

resource "azurerm_resource_group" "terraform-KeyVaults" {
    name = "terraform-KeyVaults"
    location = "West US"
}

resource "azurerm_key_vault" "terraform-certs" {
    name = "terraform-certs"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.terraform-KeyVaults.name}"

    sku {
        name = "standard"
    }

    tenant_id = "d017007d-9b9c-44cc-84d8-95533b70f026"

    access_policy {
        tenant_id = "d017007d-9b9c-44cc-84d8-95533b70f026"
        object_id = "00dbbe30-2166-4d6a-b8a2-a7d876a6ec9e"
        key_permissions = [
            "all"
        ]
        secret_permissions = [
            "get"
        ]
    }

    enabled_for_disk_encryption = true

    tags {
        environment = "Production"
    }
}


resource "azurerm_key_vault" "terraform-secrets" {
    name = "terraform-secrets"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.terraform-KeyVaults.name}"

    sku {
        name = "standard"
    }

    tenant_id = "d017007d-9b9c-44cc-84d8-95533b70f026"

    access_policy {
        tenant_id = "d017007d-9b9c-44cc-84d8-95533b70f026"
        object_id = "00dbbe30-2166-4d6a-b8a2-a7d876a6ec9e"
        object_id = "00dbbe30-2166-4d6a-b8a2-a7d876a6ec9e"
        key_permissions = [
            "all"
        ]
        secret_permissions = [
            "get"
        ]
    }

    enabled_for_disk_encryption = true

    tags {
        environment = "Production"
    }
}
