# terraform-azure-aks

Terraform module to deploy an aks cluster at azure

## Description

This module creates an aks cluster and a `service pricipal` dedicated to its resources, a virtual network and subnet needs to be previously created. There is also the option to create a `storage account` of the MC resource group, to be used as persistence.

## Example usage

- Creating a cluster containing usage nodepool

```hcl
location = "eastus2"
resource_group = "rg-my-cluster"
aks_name = "my-cluster"
admin_username = "my-user"
node_count = 1
auto_scaling_default_node = false
node_min_count = null
node_max_count = null
default_node_vm_size = "Standard_DS2_v2"

additional_node_pools = {
  "pooltest" = {
		vm_size = "Standard_DS2_v2"
    os_disk_size_gb = 100
		enable_auto_scaling = false
    availability_zones  = []
    node_count          = 1
    min_count           = null
    max_count           = null
    max_pods            = 110
    node_labels         = null
    taints              = null
  }
}

```
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_kubernetes_cluster.k8s](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_role_assignment.role_assignment_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.role_assignment_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [local_file.kubeconfig_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.delay_after_sp_created](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.unique](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.pair](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools) | (Optional) List of additional node pools to the cluster | <pre>map(object({<br>    vm_size             = string<br>    os_disk_size_gb     = number<br>    enable_auto_scaling = bool<br>    availability_zones  = list(string)<br>    node_count          = number<br>    min_count           = number<br>    max_count           = number<br>    max_pods            = number<br>    node_labels         = map(string)<br>    taints              = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The Admin Username for the Cluster. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_auto_scaling_default_node"></a> [auto\_scaling\_default\_node](#input\_auto\_scaling\_default\_node) | (Optional) Kubernetes Auto Scaler must be enabled for this main pool | `bool` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). | `string` | `"10.0.0.10"` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. | `string` | `"172.17.0.1/16"` | no |
| <a name="input_end_date"></a> [end\_date](#input\_end\_date) | The End Date which the Password is valid until, formatted as a RFC3339 date string (e.g. 2018-01-01T01:02:03Z). | `string` | `"2030-01-01T00:00:00Z"` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). | `string` | `"1.23.5"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | `110` | no |
| <a name="input_netwok_resource_group"></a> [netwok\_resource\_group](#input\_netwok\_resource\_group) | (Required) Name of the resource group that contains the virtual network | `string` | n/a | yes |
| <a name="input_network_subnet"></a> [network\_subnet](#input\_network\_subnet) | (Required) Network subnet name. | `string` | n/a | yes |
| <a name="input_network_vnet"></a> [network\_vnet](#input\_network\_vnet) | (Required) Virtual network name. | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | (Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min\_count and max\_count. | `string` | n/a | yes |
| <a name="input_node_max_count"></a> [node\_max\_count](#input\_node\_max\_count) | (Required) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100. | `number` | n/a | yes |
| <a name="input_node_min_count"></a> [node\_min\_count](#input\_node\_min\_count) | (Required) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100. | `number` | n/a | yes |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | (Optional) The CIDR to use for pod IP addresses. Changing this forces a new resource to be created. | `string` | `"10.244.0.0/16"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) Base name used by resources (cluster name, main service and others). | `string` | n/a | yes |
| <a name="input_rbac_enabled"></a> [rbac\_enabled](#input\_rbac\_enabled) | (Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | (Optional) The Network Range used by the Kubernetes service.Changing this forces a new resource to be created. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) Defines the SLA plan for the availability of system. Valid options are Free or Paid, paid option enables the Uptime SLA feature (see https://docs.microsoft.com/en-us/azure/aks/uptime-sla for more info) | `string` | `"Free"` | no |
| <a name="input_storage_account_kind"></a> [storage\_account\_kind](#input\_storage\_account\_kind) | (Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2. | `string` | `"FileStorage"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Optional) Data storage name (use lower case, no spaces and special characters ex: mystorageaccount).null empty does not create resource. | `string` | n/a | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | (Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS. | `string` | `"LRS"` | no |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | (Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Premium"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) The size of the Virtual Machine, such as Standard\_DS2\_v2. | `string` | `"Standard_DS2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name to be used in the context of kubectl |
| <a name="output_config"></a> [config](#output\_config) | Commands to configure kubectl local |
| <a name="output_kube_config_file"></a> [kube\_config\_file](#output\_kube\_config\_file) | Kubeconfig file |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | Client configuration file for connecting to the cluster |
| <a name="output_service_principal_id"></a> [service\_principal\_id](#output\_service\_principal\_id) | Service Principal ID |
| <a name="output_service_principal_secret"></a> [service\_principal\_secret](#output\_service\_principal\_secret) | Service Principal Secrets |
<!-- END_TF_DOCS -->