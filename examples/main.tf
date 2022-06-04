terraform {
  required_providers {
    azurerm = "2.46.1"
    azuread = "1.4.0"
  } 
}

provider "azurerm" {
  features {}
}

module "aks" {

  source  = "../"

  prefix         = var.aks_name
  resource_group = azurerm_resource_group.rg.name
  location       = azurerm_resource_group.rg.location
  admin_username = var.admin_username

  k8s_version = var.k8s_version

  auto_scaling_default_node = var.auto_scaling_default_node
  availability_zones        = var.availability_zones
  vm_size                   = var.default_node_vm_size
  max_pods                  = var.max_pods
  node_count                = var.node_count
  node_min_count            = var.node_min_count
  node_max_count            = var.node_max_count

  netwok_resource_group = var.resource_group_vnet == "" ? azurerm_resource_group.rg.name : var.resource_group_vnet
  network_vnet          = var.virtual_network_name == "" ? azurerm_virtual_network.vnet[0].name : var.virtual_network_name
  network_subnet        = var.subnet_network_name == "" ? azurerm_subnet.subnet[0].name : var.subnet_network_name

  service_cidr         = var.service_cidr
  dns_service_ip       = var.dns_service_ip
  pod_cidr             = var.pod_cidr
  docker_bridge_cidr   = var.docker_bridge_cidr
  storage_account_name = null

  additional_node_pools = var.additional_node_pools

  tags = var.tags

  sku_tier = var.sku_tier
}