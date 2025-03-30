resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.azure_region
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_name

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_cognitive_account" "aoai" {
  name                = var.aoai_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = "S0"

  # Required when using network_acls
  custom_subdomain_name = var.aoai_name 

  network_acls {
    default_action = "Deny"
  }
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = "aoai-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "null_resource" "aoai_secret" {
  provisioner "local-exec" {
    command = <<EOT
      AOAI_ENDPOINT=$(az cognitiveservices account show -n ${azurerm_cognitive_account.aoai.name} -g ${azurerm_resource_group.rg.name} --query 'properties.endpoint' -o tsv)
      AOAI_KEY=$(az cognitiveservices account keys list -n ${azurerm_cognitive_account.aoai.name} -g ${azurerm_resource_group.rg.name} --query 'key1' -o tsv)

      kubectl create secret generic aoai --from-literal=OPENAI_API_KEY=$AOAI_KEY --from-literal=OPENAI_ENDPOINT=https://openai-internal-service
    EOT
  }
}

