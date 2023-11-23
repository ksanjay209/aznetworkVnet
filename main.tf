resource "azurerm_resource_group" "resourcegroups" {
  for_each  = var.ResourceGroups
  name      = each.value
  location  = var.Location
}

module "HubvNet" {
  source              = "Azure/network/azurerm"
  vnet_name           = var.HubvNet.vNetName
  resource_group_name = var.ResourceGroups.HubNetwork
  address_space       = var.HubvNet.address_space
  subnet_prefixes     = [var.HubvNet.GatewaySubnetPrefix, var.HubvNet.HubCoreVMSubnetPrefix, var.HubvNet.HubSharedServicesSubnetPrefix]
  subnet_names        = [var.HubvNet.GatewaySubnetName, var.HubvNet.HubCoreVMSubnetName, var.HubvNet.HubSharedServicesSubnetName]
  use_for_each        = true
  depends_on = [azurerm_resource_group.resourcegroups]
}
module "SpokevNet" {
  source              = "Azure/network/azurerm"
  vnet_name           = var.SpokevNet.vNetName
  resource_group_name = var.ResourceGroups.SpokeNetwork
  address_space       = var.SpokevNet.address_space
  subnet_prefixes     = [var.SpokevNet.SpokeCoreVMSubnetPrefix, var.SpokevNet.SpokeSharedServicesSubnetPrefix, var.SpokevNet.SpokeCitrixCoreSubnetPrefix,var.SpokevNet.SpokeSilo1SubnetPrefix]
  subnet_names        = [var.SpokevNet.SpokeCoreVMSubnetName, var.SpokevNet.SpokeSharedServicesSubnetName, var.SpokevNet.SpokeCitrixCoreSubnetName,var.SpokevNet.SpokeSilo1SubnetName]
  use_for_each        = true
  depends_on = [azurerm_resource_group.resourcegroups]
}
resource "azurerm_virtual_network_peering" "Hub-2-Spoke-Peering" {
  name                      = "Hub-2-Spoke-Peering"
  resource_group_name       = var.ResourceGroups.HubNetwork
  virtual_network_name      = var.HubvNet.vNetName
  remote_virtual_network_id = module.SpokevNet.vnet_id
}

resource "azurerm_virtual_network_peering" "Spoke-2-Hub-Peering" {
  name                      = "Spoke-2-Hub-Peering"
  resource_group_name       = var.ResourceGroups.SpokeNetwork
  virtual_network_name      = var.SpokevNet.vNetName
  remote_virtual_network_id = module.HubvNet.vnet_id
}