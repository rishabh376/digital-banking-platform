variable "name" {}
variable "rg" {}

resource "azurerm_mssql_server" "sqlsrv" {
  name                         = var.name
  resource_group_name          = var.rg
  location                     = azurerm_resource_group.rg.location
  administrator_login          = "sqladminuser"
  administrator_login_password = random_password.pw.result
  version                      = "12.0"
}

resource "azurerm_mssql_database" "sqldb" {
  name                = "${var.name}-db"
  server_id           = azurerm_mssql_server.sqlsrv.id
  sku_name            = "S0"
}
