# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "8c6f9e0e-915e-4898-b190-8494072467b2"
  client_id       = "7cb89389-135d-463e-8b69-e8c97c297026"
  client_secret   = "UYASDGas5dfaghuy&*YGusysd"
  tenant_id       = "d017007d-9b9c-44cc-84d8-95533b70f026"
}

resource "azurerm_resource_group" "test" {
    name = "TerraformVM"
    location = "West Europe"
}

resource "azurerm_virtual_network" "test" {
    name = "vNet1"
    address_space = ["10.0.0.0/16"]
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.test.name}"
}

resource "azurerm_subnet" "test" {
    name = "Subnet1"
    resource_group_name = "${azurerm_resource_group.test.name}"
    virtual_network_name = "${azurerm_virtual_network.test.name}"
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_subnet" "test2" {
    name = "Subnet2"
    resource_group_name = "${azurerm_resource_group.test.name}"
    virtual_network_name = "${azurerm_virtual_network.test.name}"
    address_prefix = "10.0.3.0/24"
}

resource "azurerm_subnet" "test3" {
    name = "Subnet3"
    resource_group_name = "${azurerm_resource_group.test.name}"
    virtual_network_name = "${azurerm_virtual_network.test.name}"
    address_prefix = "10.0.4.0/24"
}

resource "azurerm_subnet" "test8" {
    name = "Subnet8"
    resource_group_name = "${azurerm_resource_group.test.name}"
    virtual_network_name = "${azurerm_virtual_network.test.name}"
    address_prefix = "10.0.8.0/24"
}

resource "azurerm_subnet" "test4" {
    name = "Subnet3"
    resource_group_name = "${azurerm_resource_group.test.name}"
    virtual_network_name = "${azurerm_virtual_network.test.name}"
    address_prefix = "10.0.5.0/24"
}

resource "azurerm_network_interface" "test" {
    name = "TerraformVM-NIC-02"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.test.name}"

    ip_configuration {
        name = "Standard"
        subnet_id = "${azurerm_subnet.test.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_storage_account" "test" {
    name = "jacobterraformvmstor01"
    resource_group_name = "${azurerm_resource_group.test.name}"
    location = "westeurope"
    account_type = "Standard_LRS"

    tags {
        environment = "staging"
    }
}

resource "azurerm_storage_container" "test" {
    name = "vhds"
    resource_group_name = "${azurerm_resource_group.test.name}"
    storage_account_name = "${azurerm_storage_account.test.name}"
    container_access_type = "private"
}

resource "azurerm_virtual_machine" "test" {
    name = "TerraformVM01"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.test.name}"
    network_interface_ids = ["${azurerm_network_interface.test.id}"]
    vm_size = "Standard_A1"

    storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }

    storage_os_disk {
        name = "TerraformOSdisk"
        vhd_uri = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/terraformOSdisk.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
    }

 

    os_profile {
        computer_name = "TerraformVM01"
        admin_username = "jacob.poot"
        admin_password = "UYSDGCs56dgvhjaUGGY"
    }
  
    tags {
        environment = "staging"
    }
}


