output "vnet_ids" {
  description = "Virtual network resource IDs keyed by the input map keys."
  value       = { for key, vnet in azurerm_virtual_network.vnet : key => vnet.id }
}
