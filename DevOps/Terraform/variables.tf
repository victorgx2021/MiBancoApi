variable "environment" {
  type        = string
  description = "Name of the environment, Example: qa, dev"
}

variable "iteration_rg" {
  description = "Iteration number"
  type        = string
}

variable "location" {
  type        = string
  description = "Region of the Azure"
  default     = "brazilsouth"
}
