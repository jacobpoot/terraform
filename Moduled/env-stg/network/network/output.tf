output "subnet_pkvl_id" {
  value = "${azurerm_subnet.prd-kvl.id}"
}

output "subnet_pogd_id" {
  value = "${azurerm_subnet.prd-ogd.id}"
}

output "subnet_psrl_id" {
  value = "${azurerm_subnet.prd-srl.id}"
}

output "subnet_pstg_id" {
  value = "${azurerm_subnet.prd-stg.id}"
}

output "subnet_prcz_id" {
  value = "${azurerm_subnet.prd-rcz.id}"
}

output "subnet_skvl_id" {
  value = "${azurerm_subnet.stg-kvl.id}"
}

output "subnet_sogd_id" {
  value = "${azurerm_subnet.stg-ogd.id}"
}

output "subnet_srcz_id" {
  value = "${azurerm_subnet.stg-rcz.id}"
}

output "subnet_ssrl_id" {
  value = "${azurerm_subnet.stg-srl.id}"
}
