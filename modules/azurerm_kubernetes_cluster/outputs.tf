output "kubelet_identity_object_ids" {
  description = "AKS kubelet managed identity object IDs keyed by the input map keys."
  value       = { for key, cluster in azurerm_kubernetes_cluster.aks : key => cluster.kubelet_identity[0].object_id }
}

output "cluster_ids" {
  description = "AKS resource IDs keyed by the input map keys."
  value       = { for key, cluster in azurerm_kubernetes_cluster.aks : key => cluster.id }
}
