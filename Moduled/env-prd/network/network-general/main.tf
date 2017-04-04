resource "azurerm_resource_group" "network" {
  name     = "terraform-network-01"
  location = "${var.location}"
}

terraform {
  backend "azure" {
    storage_account_name = "terraformstatedata"
    container_name       = "terraform-backend"
    key                  = "env-prd-network-general-01"
  }
}

resource "azurerm_virtual_network" "network" {
  name                = "VNET-01"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}

resource "azurerm_subnet" "gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.240.0/24"
}

resource "azurerm_subnet" "gitlab-subnet" {
  name                 = "10.0.1.0-28-GITLAB-SUBNET"
  resource_group_name  = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.1.0/24"
}

#resource "azurerm_local_network_gateway" "local-network-gateway-01" {
#  name                = "OGD-EUW-LNG-BIR-KLANTENPLEIN-01"
#  resource_group_name = "${azurerm_resource_group.network.name}"
#  location            = "${azurerm_resource_group.network.location}"
#  gateway_address     = "87.213.75.202"
#  address_space       = ["10.240.240.0/24", "10.240.241.0/24"]
#}


#resource "azurerm_public_ip" "virtual-network-gateway" {
#  name                         = "${var.vng_name}-PIP-01"
#  location                     = "${azurerm_resource_group.network.location}"
#  resource_group_name          = "${azurerm_resource_group.network.name}"
#  public_ip_address_allocation = "Dynamic"


#domain_name_label            = "${lower(${var.vng_name})}"


#  tags {
#    terraformManaged = "true"
#    environment      = "${var.tag_environment}"
#  }
#}


#data "template_file" "virtual-network-gateway" {
#  template = "${file("../../../file/network/network/virtual-network-gateway.json")}"


#  vars {
#    name            = "${var.vng_name}"
#    gateway_type    = "${var.vng_gateway_type}"
#    sku             = "${var.vng_sku}"
#    vpn_type        = "${var.vng_vpn_type}"
#    public_ip_name  = "${azurerm_public_ip.virtual-network-gateway.name}"
#    vnet_name       = "${azurerm_virtual_network.network.name}"
#    tag_environment = "${var.tag_environment}"
#  }
#}


#resource "azurerm_template_deployment" "virtual-network-gateway" {
#  name                = "${var.vng_name}"
#  resource_group_name = "${azurerm_resource_group.network.name}"
#  depends_on          = ["azurerm_subnet.gateway-subnet", "azurerm_public_ip.virtual-network-gateway"]


#  template_body   = "${data.template_file.virtual-network-gateway.rendered}"
#  deployment_mode = "Incremental"
#}


#data "template_file" "connection-01" {
#  template = "${file("../../../file/network/network/connection.json")}"
#
#  vars {
#    name            = "${var.con_name}"
#    psk             = "${var.con_psk}"
#    lng_name        = "${azurerm_local_network_gateway.local-network-gateway-01.name}"
#    vng_name        = "${azurerm_template_deployment.virtual-network-gateway.name}"
#    tag_environment = "${var.tag_environment}"
#  }
#}


#resource "azurerm_template_deployment" "connection-01" {
#  name                = "${var.con_name}"
#  resource_group_name = "${azurerm_resource_group.network.name}"
#  depends_on          = ["azurerm_template_deployment.virtual-network-gateway", "azurerm_local_network_gateway.local-network-gateway-01"]


#  template_body   = "${data.template_file.connection-01.rendered}"
#  deployment_mode = "Incremental"
#}

