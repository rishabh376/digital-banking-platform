variable "prefix" { type = string, default = "RRbank" }
variable "location_primary" { type = string, default = "eastus" }
variable "location_secondary" { type = string, default = "eastus2" }
variable "resource_group_name" { type = string, default = "RRbank-rg" }
variable "aks_node_count" { type = number, default = 3 }
