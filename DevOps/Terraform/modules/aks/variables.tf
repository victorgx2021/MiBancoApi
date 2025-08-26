#Azure kubernetes service
variable "aks_default_node" {
  type = object({
    name = string
    size = string
    node_count = number
  })
}

variable "aks_other_nodes" {
  type = list(object({
    name = string
    size = string
    node_count = number
    mode = string
  }))

  default = []
}

variable "aks_authorize_ip_list" {
  type = list(string)
  default = []
}

variable "iteration" {
  description = "Iteration number"
  type        = string
  default = ""
}

#General variables
variable "resource_group_name" {
  type = string
}

variable "workload" {
  type = string
  default = "mibanco"
  description = "Workload, application or project"
}

variable "environment" {
  description = "Name of the environment, Example: qa, dev"
  type = string
}

variable "location" {
  description = "Region of the Azure"
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
  description = "tags to attach with resources"
}

variable "iteration_rg" {
  description = "Iteration number"
  type        = string

  validation {
    condition     = can(regex("^[0-9][0-9][0-9]$", var.iteration_rg))
    error_message = "The iteration must be a three-digit number (e.g., '001', '002')."
  }
}
