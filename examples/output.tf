output "cluster_name" {
  description = "Cluster name to be used in the context of kubectl"
  value       = module.aks.cluster_name
}