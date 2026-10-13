variable "registries" {
  description = "Container registries to create, keyed by a stable logical name."
  nullable    = false
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    sku                           = string
    public_network_access_enabled = bool
    zone_redundancy_enabled       = bool
    aks_kubelet_object_id         = string
    tags                          = map(string)
  }))

  validation {
    condition = alltrue([
      for registry in values(var.registries) :
      contains(["Basic", "Standard", "Premium"], registry.sku) &&
      (!registry.zone_redundancy_enabled || registry.sku == "Premium")
    ])
    error_message = "ACR SKU must be Basic, Standard, or Premium; zone redundancy requires Premium."
  }
}
