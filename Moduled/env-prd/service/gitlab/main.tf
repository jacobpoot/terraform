# setup remote state data source
data "terraform_remote_state" "network" {
  backend = "azure"

  config {
    storage_account_name = "terraformstatedata"
    container_name       = "terraform-backend"
    key                  = "env-prd-network-general-01"
  }
}

terraform {
  backend "azure" {
    storage_account_name = "terraformstatedata"
    container_name       = "terraform-backend"
    key                  = "env-prd-gitlab-01"
  }
}

module "gitlab" {
  source = "../../../module/service/gitlab"

  location        = "${var.location}"
  rgr_name        = "${var.gitlab["rgr_name"]}"
  sta_name        = "${var.gitlab["sta_name"]}"
  vm_name         = "${var.gitlab["vm_name"]}"
  vm_size         = "${var.gitlab["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_gitlab_id}"
  admin_username  = "${var.gitlab["admin_username"]}"
  admin_password  = "${var.gitlab["admin_password"]}"
  tag_environment = "${var.gitlab["tag_environment"]}"
}
