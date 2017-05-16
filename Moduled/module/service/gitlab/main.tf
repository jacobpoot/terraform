resource "azurerm_resource_group" "gitlab" {
  name     = "${var.rgr_name}"
  location = "${var.location}"

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}

resource "azurerm_network_interface" "gitlab" {
  name                = "${var.vm_name}-NIC-01"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.gitlab.name}"

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

resource "azurerm_storage_account" "gitlab" {
  name                = "${var.sta_name}"
  resource_group_name = "${azurerm_resource_group.gitlab.name}"
  location            = "${var.location}"
  account_type        = "Standard_LRS"

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}

resource "azurerm_storage_container" "gitlab" {
  name                  = "vhds"
  resource_group_name   = "${azurerm_resource_group.gitlab.name}"
  storage_account_name  = "${azurerm_storage_account.gitlab.name}"
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "gitlab" {
  name                  = "${var.vm_name}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.gitlab.name}"
  network_interface_ids = ["${azurerm_network_interface.gitlab.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "gitlab"
    offer     = "gitlab-ce"
    sku       = "gitlab-ce"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${var.vm_name}"
    vhd_uri       = "${azurerm_storage_account.gitlab.primary_blob_endpoint}${azurerm_storage_container.gitlab.name}/${var.vm_name}-osdisk.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.vm_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  plan {
    name      = "gitlab-ce"
    publisher = "gitlab"
    product   = "gitlab-ce"
  }

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}
