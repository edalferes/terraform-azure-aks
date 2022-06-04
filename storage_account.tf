resource "azurerm_storage_account" "st" {
  count                    = var.storage_account_name != null ? 1 : 0
  name                     = var.storage_account_name
  resource_group_name      = azurerm_kubernetes_cluster.k8s.node_resource_group
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind

  tags = local.tags
}