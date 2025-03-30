variable "azure_region" {
  description = "Azure region for deployment"
  default     = "eastus"
}

variable "resource_group" {
  description = "Name of the Azure Resource Group"
  default     = "api-summit"
}

variable "aks_name" {
  description = "Name of the Azure Kubernetes Service cluster"
  default     = "api-summit-aks"
}

variable "aoai_name" {
  description = "Azure OpenAI Service name"
  default     = "api-summit-aoai"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  default     = "api-summit-vnet"
}

variable "subnet_name" {
  description = "Name of the subnet"
  default     = "api-summit-subnet"
}

variable "docker_image" {
  description = "Docker image for the web application"
  default     = "docker.io/lastcoolnameleft/bad-advice-generator"
}
