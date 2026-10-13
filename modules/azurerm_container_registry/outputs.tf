output "registry_ids" {
  description = "Container registry resource IDs keyed by the input map keys."
  value       = { for key, registry in azurerm_container_registry.acr : key => registry.id }
}

output "login_servers" {
  description = "Container registry login servers keyed by the input map keys."
  value       = { for key, registry in azurerm_container_registry.acr : key => registry.login_server }
}
