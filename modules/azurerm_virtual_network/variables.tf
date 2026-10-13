variable "vnets" {
  description = "Virtual networks to create, keyed by a stable logical name."
  nullable    = false
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
  }))

  validation {
    condition     = alltrue([for vnet in values(var.vnets) : length(vnet.address_space) > 0])
    error_message = "Each virtual network must have at least one address space."
  }
}
