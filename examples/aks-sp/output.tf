
output "service_principal_id" {
  value = module.aks.service_principal_id
}

output "service_principal_secret" {
  value = module.aks.service_principal_secret
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "kube_config_raw" {
  value     = module.aks.kube_config_raw
  sensitive = true
}

output "kube_config_file" {
  value = module.aks.kube_config_file
}

output "config" {
  value = <<EOF
Run the following commands to configure kubectl local:
$ terraform output kube_config_raw > ~/.kube/aksconfig
$ export KUBECONFIG=~/.kube/aksconfig
EOF

}