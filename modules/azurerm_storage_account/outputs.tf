output "storage_account_ids" {
  description = "Storage account IDs keyed by the input map keys."
  value       = { for key, storage in azurerm_storage_account.storage : key => storage.id }
}

output "storage_account_names" {
  description = "Storage account names keyed by the input map keys."
  value       = { for key, storage in azurerm_storage_account.storage : key => storage.name }
}
