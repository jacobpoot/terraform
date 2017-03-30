variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "vm-petl" {
  description = ""

  default = {
    rgr_name        = "OGD-EUW-RGR-PRD-BIR-SQL-01"
    sta_name        = "sandboxsqltest01"
    vm_name         = "EUW-OGD-PETL01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "OGD-ogd"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "production"
  }
}

variable "vm-pdtm" {
  description = ""

  default = {
    rgr_name        = "OGD-EUW-RGR-PRD-BIR-SQL-01"
    sta_name        = "sandboxsqltest01"
    vm_name         = "EUW-OGD-PDTM01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "OGD-ogd"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "production"
  }
}

variable "vm-prpl" {
  description = ""

  default = {
    rgr_name        = "OGD-EUW-RGR-PRD-BIR-SQL-01"
    sta_name        = "sandboxsqltest01"
    vm_name         = "EUW-OGD-PRPL01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "OGD-ogd"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "production"
  }
}
