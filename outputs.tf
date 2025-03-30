output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aoai_endpoint" {
  value = azurerm_cognitive_account.aoai.endpoint
}

output "resource_group" {
  value = azurerm_resource_group.rg.name
}