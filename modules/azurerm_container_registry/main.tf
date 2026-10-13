resource "azurerm_container_registry" "acr" {
  for_each                      = var.registries
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  sku                           = each.value.sku
  admin_enabled                 = false
  public_network_access_enabled = each.value.public_network_access_enabled
  zone_redundancy_enabled       = each.value.zone_redundancy_enabled
  tags                          = each.value.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  for_each             = var.registries
  scope                = azurerm_container_registry.acr[each.key].id
  role_definition_name = "AcrPull"
  principal_id         = each.value.aks_kubelet_object_id
  principal_type       = "ServicePrincipal"
}
