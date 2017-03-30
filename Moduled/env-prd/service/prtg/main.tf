# setup remote state data source
data "terraform_remote_state" "network" {
  backend = "azure"

  config {
    storage_account_name = "ogdeuwstaogdgpstlrpter01"
    container_name       = "terraform-backend"
    key                  = "env-tst-network-network"
    access_key           = "QwfM/rAFQcdkg1I3McXw6H3BI1Ty+VSs4dGILsgRP7tjKDRtv+zoo0GUphuPsLLbRi/bnJ4r0lzxZ+Jlbd6KQA=="
  }
}

module "vm-pptg" {
  source = "../../../module/service/prtg"

  location        = "${var.location}"
  rgr_name        = "${var.vm-pptg["rgr_name"]}"
  sta_name        = "${var.vm-pptg["sta_name"]}"
  vm_name         = "${var.vm-pptg["vm_name"]}"
  vm_size         = "${var.vm-pptg["vm_size"]}"
  vm_subnet_id    = "${data.terraform_remote_state.network.subnet_pptg_id}"
  admin_username  = "${var.vm-pptg["admin_username"]}"
  admin_password  = "${var.vm-pptg["admin_password"]}"
  tag_environment = "${var.vm-pptg["tag_environment"]}"
}
