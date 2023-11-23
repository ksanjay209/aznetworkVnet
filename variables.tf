variable "Location" {
  type    = string
  default = "WestEurope"
}
variable "ResourceGroups" {
  type = map(any)
  default = {
    "HubNetwork"          = "Terraform-Hub-Network"
    "HubCoreVMs"          = "Terraform-Hub-CoreVMs"
    "HubSharedServices"   = "Terraform-Hub-SharedServices"
    "SpokeNetwork"        = "Terraform-Spoke-Network"
    "SpokeSharedServices" = "Terraform-Spoke-SharedServices"
    "SpokeCitrixCore"     = "Terraform-Citrix-Core"
    "SpokeCitrixSilo1"    = "Terraform-Citrix-Silo1"
  }
}
variable "HubvNet" {
  type = map(any)
  default = {
    "vNetName"                      = "HubvNet"
    "address_space"                 = "172.16.0.0/16"
    "GatewaySubnetPrefix"           = "172.16.0.0/26"
    "GatewaySubnetName"             = "GatewaySubnet"
    "HubCoreVMSubnetPrefix"         = "172.16.0.64/26"
    "HubCoreVMSubnetName"           = "Core-VM"
    "HubSharedServicesSubnetPrefix" = "172.16.0.128/26"
    "HubSharedServicesSubnetName"   = "Shared-Services"
  }
}
variable "SpokevNet" {
  type = map(any)
  default = {
    "vNetName"                        = "SpokevNet"
    "address_space"                   = "172.17.0.0/16"
    "SpokeCoreVMSubnetPrefix"         = "172.17.0.64/26"
    "SpokeCoreVMSubnetName"           = "Core-VM"
    "SpokeSharedServicesSubnetPrefix" = "172.17.0.128/26"
    "SpokeSharedServicesSubnetName"   = "Shared-Services"
    "SpokeCitrixCoreSubnetPrefix"     = "172.17.0.192/26"
    "SpokeCitrixCoreSubnetName"       = "Citrix-Core-VM"
    "SpokeSilo1SubnetPrefix"          = "172.17.1.0/24"
    "SpokeSilo1SubnetName"            = "Citrix-Silo1"
  }
}