# setup remote state data source
data "terraform_remote_state" "network" {
  backend = "azure"

  config {
    storage_account_name = "terraformstatedata"
    container_name       = "terraform-backend"
    key                  = "env-prd-network-skype-01"
  }
}

terraform {
  backend "azure" {
    storage_account_name = "terraformstatedata"
    container_name       = "terraform-backend"
    key                  = "env-prd-skype-01"
  }
}

module "skype-frontend" {
  source = "../../../module/service/skype"

  location        = "${var.location}"
  rgr_name        = "${var.skype-frontend["rgr_name"]}"
  sta_name        = "${var.skype-frontend["sta_name"]}"
  vm_name         = "${var.skype-frontend["vm_name"]}"
  vm_size         = "${var.skype-frontend["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_frontend_id}"
  admin_username  = "${var.skype-frontend["admin_username"]}"
  admin_password  = "${var.skype-frontend["admin_password"]}"
  tag_environment = "${var.skype-frontend["tag_environment"]}"
}

module "skype-backend" {
  source = "../../../module/service/skype"

  location        = "${var.location}"
  rgr_name        = "${var.skype-backend["rgr_name"]}"
  sta_name        = "${var.skype-backend["sta_name"]}"
  vm_name         = "${var.skype-backend["vm_name"]}"
  vm_size         = "${var.skype-backend["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_backend_id}"
  admin_username  = "${var.skype-backend["admin_username"]}"
  admin_password  = "${var.skype-backend["admin_password"]}"
  tag_environment = "${var.skype-backend["tag_environment"]}"
}
