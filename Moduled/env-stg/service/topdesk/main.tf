# setup remote state data source
data "terraform_remote_state" "network" {
  backend = "azure"

  config {
    storage_account_name = "taseuwstaiagpstlrter01"
    container_name       = "terraform-backend"
    key                  = "env-prd-network-network"
    access_key           = "Gl2Y3uIT3YLQjSyPYEqKHj+N17ZiVsXih/z3vwynD8XbbDG6h70E5Ix94N6TgWr0R0hcgQr7FQaOjciWGcqLbw=="
  }
}

module "vm-skvl" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-skvl["rgr_name"]}"
  sta_name        = "${var.vm-skvl["sta_name"]}"
  vm_name         = "${var.vm-skvl["vm_name"]}"
  vm_size         = "${var.vm-skvl["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_skvl_id}"
  admin_username  = "${var.vm-skvl["admin_username"]}"
  admin_password  = "${var.vm-skvl["admin_password"]}"
  tag_environment = "${var.vm-skvl["tag_environment"]}"
}

module "vm-pkvl" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-pkvl["rgr_name"]}"
  sta_name        = "${var.vm-pkvl["sta_name"]}"
  vm_name         = "${var.vm-pkvl["vm_name"]}"
  vm_size         = "${var.vm-pkvl["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_pkvl_id}"
  admin_username  = "${var.vm-pkvl["admin_username"]}"
  admin_password  = "${var.vm-pkvl["admin_password"]}"
  tag_environment = "${var.vm-pkvl["tag_environment"]}"
}

module "vm-sogd" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-sogd["rgr_name"]}"
  sta_name        = "${var.vm-sogd["sta_name"]}"
  vm_name         = "${var.vm-sogd["vm_name"]}"
  vm_size         = "${var.vm-sogd["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_sogd_id}"
  admin_username  = "${var.vm-sogd["admin_username"]}"
  admin_password  = "${var.vm-sogd["admin_password"]}"
  tag_environment = "${var.vm-sogd["tag_environment"]}"
}

module "vm-pogd" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-pogd["rgr_name"]}"
  sta_name        = "${var.vm-pogd["sta_name"]}"
  vm_name         = "${var.vm-pogd["vm_name"]}"
  vm_size         = "${var.vm-pogd["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_pogd_id}"
  admin_username  = "${var.vm-pogd["admin_username"]}"
  admin_password  = "${var.vm-pogd["admin_password"]}"
  tag_environment = "${var.vm-pogd["tag_environment"]}"
}

module "vm-ssrl" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-ssrl["rgr_name"]}"
  sta_name        = "${var.vm-ssrl["sta_name"]}"
  vm_name         = "${var.vm-ssrl["vm_name"]}"
  vm_size         = "${var.vm-ssrl["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_ssrl_id}"
  admin_username  = "${var.vm-ssrl["admin_username"]}"
  admin_password  = "${var.vm-ssrl["admin_password"]}"
  tag_environment = "${var.vm-ssrl["tag_environment"]}"
}

module "vm-psrl" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-psrl["rgr_name"]}"
  sta_name        = "${var.vm-psrl["sta_name"]}"
  vm_name         = "${var.vm-psrl["vm_name"]}"
  vm_size         = "${var.vm-psrl["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_psrl_id}"
  admin_username  = "${var.vm-psrl["admin_username"]}"
  admin_password  = "${var.vm-psrl["admin_password"]}"
  tag_environment = "${var.vm-psrl["tag_environment"]}"
}

module "vm-prcz" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-prcz["rgr_name"]}"
  sta_name        = "${var.vm-prcz["sta_name"]}"
  vm_name         = "${var.vm-prcz["vm_name"]}"
  vm_size         = "${var.vm-prcz["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_prcz_id}"
  admin_username  = "${var.vm-prcz["admin_username"]}"
  admin_password  = "${var.vm-prcz["admin_password"]}"
  tag_environment = "${var.vm-prcz["tag_environment"]}"
}

module "vm-srcz" {
  source = "../../../module/service/topdesk"

  location        = "${var.location}"
  rgr_name        = "${var.vm-srcz["rgr_name"]}"
  sta_name        = "${var.vm-prcz["sta_name"]}"
  vm_name         = "${var.vm-prcz["vm_name"]}"
  vm_size         = "${var.vm-prcz["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_prcz_id}"
  admin_username  = "${var.vm-prcz["admin_username"]}"
  admin_password  = "${var.vm-prcz["admin_password"]}"
  tag_environment = "${var.vm-prcz["tag_environment"]}"
}
