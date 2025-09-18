variable "name" {}
variable "rg_name" {}

resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
