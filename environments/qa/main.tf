module "rgs" {
  source = "../../modules/azurerm_resource_group"
  rg_var = var.rg_var
}

module "vnets" {
  source = "../../modules/azurerm_virtual_network"
  vnets  = var.vnets

  depends_on = [module.rgs]
}

module "subnets" {
  source  = "../../modules/azurerm_subnet"
  subnets = var.subnets

  depends_on = [module.vnets]
}

module "aks" {
  source    = "../../modules/azurerm_kubernetes_cluster"
  tenant_id = local.tenant_id
  aks_clusters = {
    for key, cluster in var.aks_clusters : key => merge(cluster, {
      node_pool = merge(cluster.node_pool, {
        subnet_id = module.subnets.subnet_ids[cluster.node_pool.subnet_key]
      })
    })
  }

  depends_on = [module.subnets]
}

module "acrs" {
  source = "../../modules/azurerm_container_registry"
  registries = {
    for key, registry in var.registries : key => merge(registry, {
      aks_kubelet_object_id = module.aks.kubelet_identity_object_ids[registry.aks_cluster_key]
    })
  }

  depends_on = [module.aks]
}

module "stgs" {
  source     = "../../modules/azurerm_storage_account"
  storage    = var.storage
  depends_on = [module.rgs]
}