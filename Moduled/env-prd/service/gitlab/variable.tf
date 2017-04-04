variable "location" {
  description = "Location/region where the resource will be created"
  default     = "West Europe"
}

variable "gitlab" {
  description = ""

  default = {
    rgr_name        = "terraform-gitlab"
    sta_name        = "terragitjacobdata"
    vm_name         = "gitlab01"
    vm_size         = "Standard_A2_v2"
    admin_username  = "terragitlab"
    admin_password  = "Veelmakkelijker!"
    tag_environment = "production"
  }
}
