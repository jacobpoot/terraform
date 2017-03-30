# setup remote state data source
data "terraform_remote_state" "network" {
  backend = "azure"

  config {
    storage_account_name = "terraformstatedata"
    container_name       = "terraform-backend"
    key                  = "env-prd-network-01"
  }
}

terraform {
  backend "azure" {
    storage_account_name = "terraformstatedata"
    container_name       = "terraform-backend"
    key                  = "env-prd-sql-01"
  }
}

module "vm-sql" {
  source = "../../../module/service/sql"

  location        = "${var.location}"
  rgr_name        = "${var.vm-sql["rgr_name"]}"
  sta_name        = "${var.vm-sql["sta_name"]}"
  vm_name         = "${var.vm-sql["vm_name"]}"
  vm_size         = "${var.vm-sql["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_sql_id}"
  admin_username  = "${var.vm-sql["admin_username"]}"
  admin_password  = "${var.vm-sql["admin_password"]}"
  tag_environment = "${var.vm-sql["tag_environment"]}"
}

module "vm-hrm" {
  source = "../../../module/service/sql"

  location        = "${var.location}"
  rgr_name        = "${var.vm-hrm["rgr_name"]}"
  sta_name        = "${var.vm-hrm["sta_name"]}"
  vm_name         = "${var.vm-hrm["vm_name"]}"
  vm_size         = "${var.vm-hrm["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_hrm_id}"
  admin_username  = "${var.vm-hrm["admin_username"]}"
  admin_password  = "${var.vm-hrm["admin_password"]}"
  tag_environment = "${var.vm-hrm["tag_environment"]}"
}

module "vm-monitoring" {
  source = "../../../module/service/sql"

  location        = "${var.location}"
  rgr_name        = "${var.vm-monitoring["rgr_name"]}"
  sta_name        = "${var.vm-monitoring["sta_name"]}"
  vm_name         = "${var.vm-monitoring["vm_name"]}"
  vm_size         = "${var.vm-monitoring["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_monitoring_id}"
  admin_username  = "${var.vm-monitoring["admin_username"]}"
  admin_password  = "${var.vm-monitoring["admin_password"]}"
  tag_environment = "${var.vm-monitoring["tag_environment"]}"
}
