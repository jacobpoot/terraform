variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "vm-pkvl" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-PRD-KVL-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop01"
    vm_name         = "EUW-KVL-PTOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-KVL"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "staging"
  }
}

variable "vm-skvl" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-STG-KVL-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop02"
    vm_name         = "EUW-OGD-TTOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-KVL"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "test"
  }
}

variable "vm-pogd" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-PRD-OGD-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop03"
    vm_name         = "EUW-OGD-TTOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-ogd"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "Production"
  }
}

variable "vm-sogd" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-STG-OGD-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop04"
    vm_name         = "EUW-OGD-STOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-ogd"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "Production"
  }
}

variable "vm-psrl" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-PRD-SRL-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop05"
    vm_name         = "EUW-SRL-STOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-srl"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "Production"
  }
}

variable "vm-ssrl" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-STG-SRL-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop06"
    vm_name         = "EUW-SRL-STOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-srl"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "Production"
  }
}

variable "vm-prcz" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-PRD-RCZ-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop07"
    vm_name         = "EUW-RCZ-STOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-rcz"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "Production"
  }
}

variable "vm-srcz" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-STG-SRL-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop08"
    vm_name         = "EUW-RCZ-STOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-srl"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "Production"
  }
}

variable "vm-ptst" {
  description = ""

  default = {
    rgr_name        = "TAS-EUW-RGR-STG-TST-TOP-01"
    sta_name        = "taseuwstaogdgpstlrtop09"
    vm_name         = "EUW-TST-PTOP01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "tas-tst"
    admin_password  = "DG^%$ESDYFuysgadyatfd^YFds"
    tag_environment = "Production"
  }
}
