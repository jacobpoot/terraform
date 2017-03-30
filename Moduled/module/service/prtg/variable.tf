variable "location" {
  description = "Location of the resources."
}

variable "rgr_name" {
  description = "Name of the resource group."
}

variable "sta_name" {
  description = "Name of the storage account."
}

variable "vm_name" {
  description = "Name of the virtual machine."
}

variable "vm_size" {
  description = "Size of the virtual machine."
}

variable "vm_subnet_id" {
  description = "ID of the subnet the NIC will connect to."
}

variable "admin_username" {
  description = "Administrator username for the virtual machine."
}

variable "admin_password" {
  description = "Administrator password for the virtual machine."
}

variable "tag_environment" {
  description = "Tag describing the environment. e.g. production, staging etc."
}
