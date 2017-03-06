# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "8c6f9e0e-915e-4898-b190-8494072467b2"
  client_id       = "7cb89389-135d-463e-8b69-e8c97c297026"
  client_secret   = "UYASDGas5dfaghuy&*YGusysd"
  tenant_id       = "d017007d-9b9c-44cc-84d8-95533b70f026"
}

resource "azurerm_resource_group" "TerraformVM" {
    name = "TerraformVM"
    location = "West US"
}

resource "azurerm_virtual_network" "vNet1" {
    name = "acctvn"
    address_space = ["10.0.0.0/16"]
    location = "West US"
    resource_group_name = "${azurerm_resource_group.TerraformVM.name}"
}

resource "azurerm_subnet" "subnet" {
    name = "acctsub"
    resource_group_name = "${azurerm_resource_group.TerraformVM.name}"
    virtual_network_name = "${azurerm_virtual_network.vNet1.name}"
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_network_interface" "nic" {
    name = "TerraformVM-NIC-01"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.TerraformVM.name}"

    ip_configuration {
        name = "Standard"
        subnet_id = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_storage_account" "stor01" {
    name = "jacobterraformvmstor01"
    resource_group_name = "${azurerm_resource_group.TerraformVM.name}"
    location = "westeurope"
    account_type = "Standard_LRS"

    tags {
        environment = "staging"
    }
}

resource "azurerm_storage_container" "vhds" {
    name = "vhds"
    resource_group_name = "${azurerm_resource_group.TerraformVM.name}"
    storage_account_name = "${azurerm_storage_account.stor01.name}"
    container_access_type = "private"
}

resource "azurerm_virtual_machine" "VM" {
    name = "TerraformVM01"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.TerraformVM.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size = "Standard_A0"

    storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }

    storage_os_disk {
        name = "TerraformOSdisk"
        vhd_uri = "${azurerm_storage_account.stor01.primary_blob_endpoint}${azurerm_storage_container.stor01.name}/terraformOSdisk.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
    }

 storage_data_disk {
    name          = "datadisk0"
    vhd_uri       = "${azurerm_storage_account.stor01.primary_blob_endpoint}${azurerm_storage_container.stor01.name}/datadisk0.vhd"
    disk_size_gb  = "1023"
    create_option = "empty"
    lun           = 0
  }

   storage_data_disk {
    name          = "datadisk1"
    vhd_uri       = "${azurerm_storage_account.stor01.primary_blob_endpoint}${azurerm_storage_container.stor01.name}/datadisk1.vhd"
    disk_size_gb  = "1023"
    create_option = "empty"
    lun           = 1
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

resource "azurerm_virtual_machine_extension" "extension1" {
    name = "hostname"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.TerraformVM.name}"
    virtual_machine_name = "${azurerm_virtual_machine.VM.name}"
    publisher = "Microsoft.OSTCExtensions"
    type = "CustomScriptForWindows"
    type_handler_version = "1.2"

    settings = <<SETTINGS
    {
        "commandToExecute": "powershell.exe -ExecutionPolicy Bypass -File .\\new-prtg-server\\scripts\\prepare-prtgserver.ps1"
    }
SETTINGS

    tags {
        environment = "Production"
    }
}