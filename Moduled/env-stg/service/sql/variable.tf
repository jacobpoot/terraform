variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "vm-sql" {
  description = ""

  default = {
    rgr_name        = "terraform-SQL"
    sta_name        = "terrajacobdata01"
    vm_name         = "sql01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "ogd-bir"
    admin_password  = "HetismaarvoorTest!1"
    tag_environment = "production"
  }
}

variable "vm-monitoring" {
  description = ""

  default = {
    rgr_name        = "terraform-monitoring"
    sta_name        = "terrajacobdata02"
    vm_name         = "monitoring01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "ogd-bir"
    admin_password  = "HetismaarvoorTest!1"
    tag_environment = "production"
  }
}

variable "vm-hrm" {
  description = ""

  default = {
    rgr_name        = "teraform-hrm"
    sta_name        = "terrajacobdata03"
    vm_name         = "hrm01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "ogd-bir"
    admin_password  = "HetismaarvoorTest!1"
    tag_environment = "production"
  }
}
