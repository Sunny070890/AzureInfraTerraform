variable "tenant_id" {
  description = "Microsoft Entra tenant ID used for Azure RBAC authentication."
  type        = string
  nullable    = false
}

variable "aks_clusters" {
  description = "AKS clusters to create, keyed by a stable logical name."
  nullable    = false
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
      subnet_id       = string
    })
    network = object({
      pod_cidr       = string
      service_cidr   = string
      dns_service_ip = string
    })
  }))

  validation {
    condition = alltrue([
      for cluster in values(var.aks_clusters) :
      cluster.node_pool.min_count >= 1 &&
      cluster.node_pool.max_count >= cluster.node_pool.min_count &&
      cluster.node_pool.os_disk_size_gb >= 30
    ])
    error_message = "AKS node pools must have at least one node, max_count >= min_count, and an OS disk of at least 30 GB."
  }
}
