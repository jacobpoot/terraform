variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "skype-frontend" {
  description = ""

  default = {
    rgr_name        = "terraform-skype"
    sta_name        = "terraskypejacobdata"
    vm_name         = "skype-frontend"
    vm_size         = "Standard_A2_v2"
    admin_username  = "terra-skype"
    admin_password  = "HetismaarvoorTest!1"
    tag_environment = "production"
  }
}

variable "skype-backend" {
  description = ""

  default = {
    rgr_name        = "terraform-skype"
    sta_name        = "terraskypejacobdata"
    vm_name         = "skype-backend"
    vm_size         = "Standard_A2_v2"
    admin_username  = "terra-skype"
    admin_password  = "HetismaarvoorTest!1"
    tag_environment = "production"
  }
}
