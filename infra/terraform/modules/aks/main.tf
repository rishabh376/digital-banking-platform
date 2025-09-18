variable "name" {}
variable "rg" {}
variable "location" { default = "eastus" }
variable "node_count" { default = 3 }

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg
  dns_prefix          = var.name

  default_node_pool {
    name       = "agentpool"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled = true
    }
  }

  network_profile {
    network_plugin = "azure"
  }

  role_based_access_control {
    enabled = true
  }
}

output "kube_admin_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive = true
}
