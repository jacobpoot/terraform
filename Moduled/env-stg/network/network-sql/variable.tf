variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "vng_name" {
  description = "Name of the Virtual Network Gateway"
  default     = "VNET-01"
}

variable "vng_gateway_type" {
  description = "Virtual Network Gateway type. Can be Vpn or ExpressRoute."
  default     = "Vpn"
}

variable "vng_sku" {
  description = "Performance level of the Virtual Network Gateway. Allowed values are Basic, Standard and HighPerformance"
  default     = "Basic"
}

variable "vng_vpn_type" {
  description = "VPN type used by the Virtual Network Gateway. Allowed values are RouteBased and Policy."
  default     = "RouteBased"
}

variable "con_name" {
  description = "Name of the Connection."
  default     = "VPN-CONNECTION-01"
}

variable "con_psk" {
  description = "Pre-Shared Key used by the Connection."
  default     = "justatestpassw0RD!"
}

variable "tag_environment" {
  description = "Tag describing the environment. e.g. production, staging etc."
  default     = "production"
}
