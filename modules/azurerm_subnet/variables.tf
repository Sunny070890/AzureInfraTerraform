variable "subnets" {
  description = "Subnets to create, keyed by a stable logical name."
  nullable    = false
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))

  validation {
    condition     = alltrue([for subnet in values(var.subnets) : length(subnet.address_prefixes) > 0])
    error_message = "Each subnet must have at least one address prefix."
  }
}
