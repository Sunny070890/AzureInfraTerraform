output "subnet_ids" {
  description = "Subnet resource IDs keyed by the input map keys."
  value       = { for key, subnet in azurerm_subnet.subnet : key => subnet.id }
}
