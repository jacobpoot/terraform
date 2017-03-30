resource "azurerm_resource_group" "skype" {
  name     = "${var.rgr_name}"
  location = "${var.location}"

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}

resource "azurerm_network_interface" "skype" {
  name                = "${var.vm_name}-NIC-01"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.skype.name}"

  ip_configuration {
    name                          = "Standard"
    subnet_id                     = "${var.vm_subnet_id}"
    private_ip_address_allocation = "dynamic"
  }

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}

resource "azurerm_storage_account" "skype" {
  name                = "${var.sta_name}"
  resource_group_name = "${azurerm_resource_group.skype.name}"
  location            = "${var.location}"
  account_type        = "Standard_LRS"

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}

resource "azurerm_storage_container" "skype" {
  name                  = "vhds"
  resource_group_name   = "${azurerm_resource_group.skype.name}"
  storage_account_name  = "${azurerm_storage_account.skype.name}"
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "skype" {
  name                  = "${var.vm_name}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.skype.name}"
  network_interface_ids = ["${azurerm_network_interface.skype.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "SQL2016SP1-WS2016"
    sku       = "Enterprise"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${var.vm_name}"
    vhd_uri       = "${azurerm_storage_account.skype.primary_blob_endpoint}${azurerm_storage_container.skype.name}/${var.vm_name}-osdisk.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  storage_data_disk {
    name          = "${var.vm_name}-datadisk-01"
    caching       = "ReadOnly"
    vhd_uri       = "${azurerm_storage_account.skype.primary_blob_endpoint}${azurerm_storage_container.skype.name}/${var.vm_name}-datadisk-01.vhd"
    create_option = "empty"
    disk_size_gb  = "1023"
    lun           = "0"
  }

  storage_data_disk {
    name          = "${var.vm_name}-datadisk-02"
    vhd_uri       = "${azurerm_storage_account.skype.primary_blob_endpoint}${azurerm_storage_container.skype.name}/${var.vm_name}-datadisk-02.vhd"
    create_option = "empty"
    disk_size_gb  = "1023"
    lun           = "1"
  }

  os_profile {
    computer_name  = "${var.vm_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}
