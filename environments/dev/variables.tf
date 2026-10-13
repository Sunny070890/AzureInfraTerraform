variable "rg_var" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}

variable "vnets" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
  }))
}

variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "aks_clusters" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    kubernetes_version  = string
    sku_tier            = string
    tags                = map(string)
    node_pool = object({
      name            = string
      vm_size         = string
      min_count       = number
      max_count       = number
      os_disk_size_gb = number
      subnet_key      = string
    })
    network = object({
      pod_cidr       = string
      service_cidr   = string
      dns_service_ip = string
    })
  }))
}

variable "registries" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    sku                           = string
    public_network_access_enabled = bool
    zone_redundancy_enabled       = bool
    aks_cluster_key               = string
    tags                          = map(string)
  }))
}

variable "storage" {
  type = map(object({
    storage_acc_name         = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    tags                     = map(string)
  }))
}
