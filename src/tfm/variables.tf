variable "root_id" {
  type    = string
  default = "orgid"
}

variable "root_name" {
  type    = string
  default = "organization id"
}
variable "target_mg_id" {
  type        = string
  description = "target management group id"
}

variable "target_mg_name" {
  type        = string
  description = "target management group name"
}

variable "primary_location" {
  type    = string
  default = "centralus"
}

variable "secondary_location" {
  type    = string
  default = "eastus2"
}
variable "identitySubscriptionId" {
  type    = string
}
variable "managementSubscriptionId" {
  type    = string
}

variable "iacSubscriptionId" {
  type    = string
}

variable "connectivitySubscriptionId" {
  type    = string
}

variable "UAMI_NAME" {
  type        = string
  description = "prefix for user managed identity"
}

variable "dcr_nstance" {
  type = string
  description = "DCR name"
}