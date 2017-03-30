output "subnet_petl_id" {
  value = "${azurerm_subnet.prd-etl.id}"
}

output "subnet_pdtm_id" {
  value = "${azurerm_subnet.prd-dtm.id}"
}

output "subnet_prpl_id" {
  value = "${azurerm_subnet.prd-rpl.id}"
}
