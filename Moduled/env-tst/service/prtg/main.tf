# setup remote state data source
data "terraform_remote_state" "network" {
  backend = "azure"

  config {
    storage_account_name = "sandboxremotestate01"
    container_name       = "terraform-backend"
    key                  = "env-tst-network-network"
    access_key           = "Gl2Y3uIT3YLQjSyPYEqKHj+N17ZiVsXih/z3vwynD8XbbDG6h70E5Ix94N6TgWr0R0hcgQr7FQaOjciWGcqLbw=="
  }
}

