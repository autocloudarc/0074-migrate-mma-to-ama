variable "rgp_idy" {
  type        = string
  description = "values for resource group name"
  default     = "rgp-idy"
}

variable "rgp_iac" {
  type        = string
  description = "values for resource group name"
  default     = "rgp-iac"
  
}
variable "root_id" {
  type        = string
  description = "root id value for organization"
}

variable "root_name" {
  type        = string
  description = "root name value for organization"
}

variable "target_mg_id" {
  type        = string
  description = "root id value for organization"
}

variable "target_mg_name" {
  type        = string
  description = "root name value for organization"
}

variable "primary_location" {
  type        = string
  description = "primary azure region value for organization"
}

variable "secondary_location" {
  type        = string
  description = "secondary azure region value for organization"
}

variable "identitySubscriptionId" {
  type        = string
  description = "identity subscription id"
}

variable "umi_name" {
  type        = string
  description = "prefix for user managed identity"
}

variable "dcr_instance" {
  type = string
  description = "DCR name"
}

variable "umi_pol_name" {
  type        = string
  description = "user managed identity for assigning initiative to targeted management group scope"
  default     = "umi-ama-mig-001"
}

variable "umi_pol_id" {
  type        = string
  description = "user managed identity policy id for initiative assignments"
  default = "/subscriptions/e25024e7-c4a5-4883-80af-9e81b2f8f689/resourceGroups/rgp-iac/providers/Microsoft.ManagedIdentity/userAssignedIdentities/umi-ama-mig-001"
}

variable "ama_initiative_assignment" {
  type = map(string)
  description = "Enable Azure Monitor for VMs AMA"
  default = {
    name_dcr = "enable-ama-dcr"
    display_name = "Enable Azure Monitor for VMs with Azure Monitoring Agent(AMA)"
    assignment_id_dcr = "/providers/microsoft.management/managementgroups/org-id-platform/providers/microsoft.authorization/policyassignments/enable-az-monitor-ama-dcr"
    policy_set_def_id = "/providers/Microsoft.Authorization/policySetDefinitions/924bfe3a-762f-40e7-86dd-5c8b95eb09e6"

    name_hybrid_dcr = "enable-ama-hybrid-dcr"
    policy_set_hybrid_vm_def_display_name = "Enable Azure Monitor for Hybrid VMs with AMA"
    assignment_id_dcr_hybrid = "/providers/microsoft.management/managementgroups/org-id-platform/providers/microsoft.authorization/policyassignments/ama-arc-dcr"
    policy_set_hybrid_vm_def_id = "/providers/Microsoft.Authorization/policySetDefinitions/2b00397d-c309-49c4-aa5a-f0b2c5bc6321"
    effect = "DeployIfNotExists"
  
    dcrResourceId = "/subscriptions/019181ad-6356-46c6-b584-444846096085/resourceGroups/rgp-idy/providers/Microsoft.Insights/dataCollectionRules/dcr"
    remediation_name_dcr = "remediate-az-monitor-ama-dcr"
  }
}

variable "umi_vm_policy" {
  type = map(string)
  description = "[Preview]: Assign Built-In User-Assigned Managed Identity to Virtual Machines"
  default = {
    name = "d367bd60-64ca-4364-98ea-276775bddd94"
    assignment_name = "assign-umi-vm-policy"
    defId  = "/providers/Microsoft.Authorization/policyDefinitions/d367bd60-64ca-4364-98ea-276775bddd94"
  }
}

variable "ama_init_bool" {
  type        = map(bool)
  description = "Boolean values for Azure Monitor for VMs with Azure Monitoring Agent(AMA)"
  default     = {
    enableProcessesAndDependencies = false
    bringYourOwnUserAssignedManagedIdentity = true
    scopeToSupportedImages = true
  }  
}

variable "mgt_law" {
  type        = map(string)
  description = "management log analytics workspace settings from landing zone"
  default = {
    name = "log-management"
    rgp  = "rg-management"
  }
}


variable "hub_vnt" {
  type        = map(string)
  description = "hub virtual network settings from landing zone"
  default = {
    name = "vnet-hub"
    rgp  = "rg-connectivity"
  }
}

variable "hvn" {
  type        = list(string)
  description = "address spaces for hub virtual network"
  default = ["10.160.0.0/22"]
}

variable "managementSubscriptionId" {
  type    = string
}

variable "connectivitySubscriptionId" {
  type    = string
}

variable "dcr_prefix" {
  type        = map(string)
  description = "DCR rule types and name"
  default = {
    dcr = "dcr"
  }
}