resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.aks_clusters
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version  = each.value.kubernetes_version

  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  private_dns_zone_id                 = "System"
  local_account_disabled              = true
  run_command_enabled                 = false
  sku_tier                            = each.value.sku_tier
  azure_policy_enabled                = true
  oidc_issuer_enabled                 = true
  workload_identity_enabled           = true

  default_node_pool {
    name                         = each.value.node_pool.name
    vm_size                      = each.value.node_pool.vm_size
    auto_scaling_enabled         = true
    min_count                    = each.value.node_pool.min_count
    max_count                    = each.value.node_pool.max_count
    os_disk_size_gb              = each.value.node_pool.os_disk_size_gb
    vnet_subnet_id               = each.value.node_pool.subnet_id
    only_critical_addons_enabled = true
    tags                         = each.value.tags
    upgrade_settings {
      max_surge = "33%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    tenant_id          = var.tenant_id
    azure_rbac_enabled = true
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    pod_cidr            = each.value.network.pod_cidr
    service_cidr        = each.value.network.service_cidr
    dns_service_ip      = each.value.network.dns_service_ip
    load_balancer_sku   = "standard"
    outbound_type       = "loadBalancer"
  }

  tags = each.value.tags
}
