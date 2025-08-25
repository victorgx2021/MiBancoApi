variable "workload" {
  type = string
  default = "mibanco"
  description = "Workload, application or project"
}

variable "environment" {
  type = string
  description = "Name of the environment, Example: qa, dev"
}

variable "location" {
  type = string
  description = "Region of the Azure"

  validation {
    condition     = can(regex("^(westus|eastus)(2|3)?$", var.location))
    error_message = "The location must be one of the following: 'westus', 'westus2', 'eastus', or 'eastus2'."
  }
}

variable "iteration_rg" {
  description = "Iteration number"
  type        = string

  validation {
    condition     = can(regex("^[0-9][0-9][0-9]$", var.iteration_rg))
    error_message = "The iteration must be a three-digit number (e.g., '001', '002')."
  }
}

variable "tags" {
  type = map(string)
  default = {}
  description = "tags to attach with resources"
}