output "resource_group_names" {
  description = "Resource group names for this environment."
  value       = module.rgs.resource_group_names
}

output "vnet_ids" {
  description = "Virtual network IDs for this environment."
  value       = module.vnets.vnet_ids
}

output "subnet_ids" {
  description = "Subnet IDs for this environment."
  value       = module.subnets.subnet_ids
}

output "aks_cluster_ids" {
  description = "AKS cluster IDs for this environment."
  value       = module.aks.cluster_ids
}

output "acr_login_servers" {
  description = "ACR login servers for this environment."
  value       = module.acrs.login_servers
}

output "storage_account_names" {
  description = "Storage account names for this environment."
  value       = module.stgs.storage_account_names
}
