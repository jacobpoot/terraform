output "subnet_sql_id" {
  value = "${azurerm_subnet.sql-subnet.id}"
}

output "subnet_monitoring_id" {
  value = "${azurerm_subnet.monitoring-subnet.id}"
}

output "subnet_bi_id" {
  value = "${azurerm_subnet.bi-subnet.id}"
}

output "subnet_hrm_id" {
  value = "${azurerm_subnet.hrm-subnet.id}"
}
