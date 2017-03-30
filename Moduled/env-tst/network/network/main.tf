resource "azurerm_resource_group" "network" {
  name     = "OGD-EUW-RGR-PRD-BIR-NETWORK-01"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "network" {
  name                = "OGD-EUW-VNT-BIR-NETWORK-01"
  address_space       = ["10.192.0.0/16"]
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
  address_prefix       = "10.192.255.192/26"
}

resource "azurerm_subnet" "application-gateway-subnet" {
  name                 = "ApplicationGatewaySubnet"
  resource_group_name  = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.192.255.128/26"
}

resource "azurerm_subnet" "prd-etl" {
  name                 = "10.192.1.0-28-PRD-ETL"
  resource_group_name  = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.192.1.16/28"
}

resource "azurerm_subnet" "prd-dtm" {
  name                 = "10.192.2.0-28-PRD-DTM"
  resource_group_name  = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.192.2.16/28"
}

resource "azurerm_subnet" "prd-rpl" {
  name                 = "10.192.3.0-28-PRD-RPL"
  resource_group_name  = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.192.3.16/28"
}

resource "azurerm_local_network_gateway" "local-network-gateway-01" {
  name                = "OGD-EUW-LNG-BIR-KLANTENPLEIN-01"
  resource_group_name = "${azurerm_resource_group.network.name}"
  location            = "${azurerm_resource_group.network.location}"
  gateway_address     = "87.213.75.202"
  address_space       = ["10.240.240.0/24", "10.240.241.0/24"]
}

resource "azurerm_public_ip" "virtual-network-gateway" {
  name                         = "${var.vng_name}-PIP-01"
  location                     = "${azurerm_resource_group.network.location}"
  resource_group_name          = "${azurerm_resource_group.network.name}"
  public_ip_address_allocation = "Dynamic"

  #domain_name_label            = "${lower(${var.vng_name})}"

  tags {
    terraformManaged = "true"
    environment      = "${var.tag_environment}"
  }
}

data "template_file" "virtual-network-gateway" {
  template = "${file("../../../file/network/network/virtual-network-gateway.json")}"

  vars {
    name            = "${var.vng_name}"
    gateway_type    = "${var.vng_gateway_type}"
    sku             = "${var.vng_sku}"
    vpn_type        = "${var.vng_vpn_type}"
    public_ip_name  = "${azurerm_public_ip.virtual-network-gateway.name}"
    vnet_name       = "${azurerm_virtual_network.network.name}"
    tag_environment = "${var.tag_environment}"
  }
}

resource "azurerm_template_deployment" "virtual-network-gateway" {
  name                = "${var.vng_name}"
  resource_group_name = "${azurerm_resource_group.network.name}"
  depends_on          = ["azurerm_subnet.gateway-subnet", "azurerm_public_ip.virtual-network-gateway"]

  template_body   = "${data.template_file.virtual-network-gateway.rendered}"
  deployment_mode = "Incremental"
}

data "template_file" "connection-01" {
  template = "${file("../../../file/network/network/connection.json")}"

  vars {
    name            = "${var.con_name}"
    psk             = "${var.con_psk}"
    lng_name        = "${azurerm_local_network_gateway.local-network-gateway-01.name}"
    vng_name        = "${azurerm_template_deployment.virtual-network-gateway.name}"
    tag_environment = "${var.tag_environment}"
  }
}

resource "azurerm_template_deployment" "connection-01" {
  name                = "${var.con_name}"
  resource_group_name = "${azurerm_resource_group.network.name}"
  depends_on          = ["azurerm_template_deployment.virtual-network-gateway", "azurerm_local_network_gateway.local-network-gateway-01"]

  template_body   = "${data.template_file.connection-01.rendered}"
  deployment_mode = "Incremental"
}
