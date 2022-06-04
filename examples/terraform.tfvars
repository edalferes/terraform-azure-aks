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