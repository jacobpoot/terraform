variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "vm-pptg" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-PRD-TAS-PTG-01"
    sta_name        = "taseuwstaogdgpstlrptg01"
    vm_name         = "EUW-TAS-PPTG01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-ogd"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "production"
  }
}
