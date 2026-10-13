output "resource_group_ids" {
  description = "Resource group IDs keyed by the input map keys."
  value       = { for key, resource_group in azurerm_resource_group.rg : key => resource_group.id }
}

output "resource_group_names" {
  description = "Resource group names keyed by the input map keys."
  value       = { for key, resource_group in azurerm_resource_group.rg : key => resource_group.name }
}
