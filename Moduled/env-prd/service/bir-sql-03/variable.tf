variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "vm-petl" {
  description = ""

  default = {
    rgr_name        = "OGD-EUW-RGR-PRD-BIR-RAP-03"
    sta_name        = "ogdeuwstabirgpstlrbir01"
    vm_name         = "EUW-BIR-PETL01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "ogd-bir"
    admin_password  = "UIFDHs7a6dtiuahdUIGAS&%$E(&YG^2e"
    tag_environment = "production"
  }
}

variable "vm-pdtm" {
  description = ""

  default = {
    rgr_name        = "OGD-EUW-RGR-PRD-BIR-RAP-03"
    sta_name        = "ogdeuwstabirgpstlrbir02"
    vm_name         = "EUW-BIR-PDTM01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "ogd-bir"
    admin_password  = "UIFDHs7a6dtiuahdUIGAS&%$E(&YG^2e"
    tag_environment = "production"
  }
}

variable "vm-prpl" {
  description = ""

  default = {
    rgr_name        = "OGD-EUW-RGR-PRD-BIR-RAP-03"
    sta_name        = "ogdeuwstabirgpstlrbir03"
    vm_name         = "EUW-BIR-PRPL01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "ogd-bir"
    admin_password  = "UIFDHs7a6dtiuahdUIGAS&%$E(&YG^2e"
    tag_environment = "production"
  }
}
