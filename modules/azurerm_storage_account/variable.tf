variable "storage" {
  type = map(object({
    storage_acc_name         = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    tags                     = map(string)
  }))
  description = "Storage accounts to create, keyed by a stable logical name."
  nullable    = false
}