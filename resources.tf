locals {

  prefix    = var.prefix
  sp_name   = "${var.prefix}-sp"
  subnet_id = data.azurerm_subnet.subnet.id
  location  = var.location
  tags      = var.tags
}

data "azurerm_subnet" "subnet" {
  name                 = var.network_subnet
  virtual_network_name = var.network_vnet
  resource_group_name  = var.netwok_resource_group
}


resource "tls_private_key" "pair" {
  algorithm = "RSA"
}

resource "local_file" "kubeconfig_file" {
  content  = azurerm_kubernetes_cluster.k8s.kube_config_raw
  filename = "${azurerm_kubernetes_cluster.k8s.name}_config"
}