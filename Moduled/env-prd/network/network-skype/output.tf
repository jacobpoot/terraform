output "subnet_frontend_id" {
  value = "${azurerm_subnet.skype-frontend.id}"
}

output "subnet_backend_id" {
  value = "${azurerm_subnet.skype-backend.id}"
}
