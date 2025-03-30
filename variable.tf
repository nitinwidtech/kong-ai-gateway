variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  default     = "6e31d38d-26b2-435f-b4bd-010764a59a32"
}

variable "azure_region" {
  description = "Azure region for deployment"
  default     = "eastus"
}

variable "resource_group" {
  description = "Name of the Azure Resource Group"
  default     = "kong-ai-gateway"
}

variable "aks_name" {
  description = "Name of the Azure Kubernetes Service cluster"
  default     = "kong-aks"
}

variable "aoai_name" {
  description = "Azure OpenAI Service name"
  default     = "kong-aoai-test2"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  default     = "kong-vnet"
}

variable "subnet_name" {
  description = "Name of the subnet"
  default     = "kong-subnet"
}

variable "docker_image" {
  description = "Docker image for the web application"
  default     = "docker.io/lastcoolnameleft/bad-advice-generator"
}
