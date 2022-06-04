resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.aks_name}-${random_string.unique.result}"
  address_space       = [var.virtual_network_address]
  location            = azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_vnet == "" ? azurerm_resource_group.rg.name : var.resource_group_vnet
  tags                = var.tags
  count               = var.virtual_network_name == "" ? 1 : 0
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${var.aks_name}-${random_string.unique.result}"
  resource_group_name  = var.resource_group_vnet == "" ? azurerm_resource_group.rg.name : var.resource_group_vnet
  virtual_network_name = var.virtual_network_name == "" ? azurerm_virtual_network.vnet[0].name : var.virtual_network_name
  address_prefixes     = var.virtual_network_name == "" ? ["10.240.0.0/16"] : [var.subnet_address]
  count                = var.subnet_network_name == "" ? 1 : 0
}

resource "random_string" "unique" {
  length  = 16
  special = false
  upper   = true
}

resource "null_resource" "get_credentials" {

  provisioner "local-exec" {

    command = "az aks get-credentials --resource-group ${azurerm_resource_group.rg.name} --name ${module.aks.cluster_name} --overwrite-existing"
  }
}

#TODO: validate this resource
resource "null_resource" "aks_update" {

  triggers = {
    aks_kubernetes_version = var.k8s_version
  }

  provisioner "local-exec" {
    command     = "../aks_update.sh ${var.aks_name} ${azurerm_resource_group.rg.name} ${var.k8s_version}"
    working_dir = path.module
  }
}

