resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location_primary
}

module "acr" {
  source  = "./modules/acr"
  rg_name = azurerm_resource_group.rg.name
  name    = "${var.prefix}acr"
}

module "aks_primary" {
  source = "./modules/aks"
  name   = "${var.prefix}-aks-primary"
  rg     = azurerm_resource_group.rg.name
  location = var.location_primary
  node_count = var.aks_node_count
}

module "sql" {
  source = "./modules/sql"
  name   = "${var.prefix}-sql"
  rg     = azurerm_resource_group.rg.name
}
# Traffic Manager, KeyVault modules…
