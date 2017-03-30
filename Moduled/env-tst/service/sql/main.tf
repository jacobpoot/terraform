# setup remote state data source
data "terraform_remote_state" "network" {
  backend = "azure"

  config {
    storage_account_name = "sandboxremotestate01"
    container_name       = "terraform-backend"
    key                  = "env-prd-network-network"
    access_key           = "tTidEeShQBF+KaKsQm4t1iN2bgwBYbfmi1dN8LUT4BVi15oIdp6rDwBRMMpUXw7vug3Z0S/yu7JKL5k8g5Amvg=="
  }
}

module "vm-petl" {
  source = "../../../module/service/sql"

  location        = "${var.location}"
  rgr_name        = "${var.vm-petl["rgr_name"]}"
  sta_name        = "${var.vm-petl["sta_name"]}"
  vm_name         = "${var.vm-petl["vm_name"]}"
  vm_size         = "${var.vm-petl["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_petl_id}"
  admin_username  = "${var.vm-petl["admin_username"]}"
  admin_password  = "${var.vm-petl["admin_password"]}"
  tag_environment = "${var.vm-petl["tag_environment"]}"
}

module "vm-pdtm" {
  source = "../../../module/service/sql"

  location        = "${var.location}"
  rgr_name        = "${var.vm-pdtm["rgr_name"]}"
  sta_name        = "${var.vm-pdtm["sta_name"]}"
  vm_name         = "${var.vm-pdtm["vm_name"]}"
  vm_size         = "${var.vm-pdtm["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_pdtm_id}"
  admin_username  = "${var.vm-pdtm["admin_username"]}"
  admin_password  = "${var.vm-pdtm["admin_password"]}"
  tag_environment = "${var.vm-pdtm["tag_environment"]}"
}

module "vm-prpl" {
  source = "../../../module/service/sql"

  location        = "${var.location}"
  rgr_name        = "${var.vm-prpl["rgr_name"]}"
  sta_name        = "${var.vm-prpl["sta_name"]}"
  vm_name         = "${var.vm-prpl["vm_name"]}"
  vm_size         = "${var.vm-prpl["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_prpl_id}"
  admin_username  = "${var.vm-prpl["admin_username"]}"
  admin_password  = "${var.vm-prpl["admin_password"]}"
  tag_environment = "${var.vm-prpl["tag_environment"]}"
}
