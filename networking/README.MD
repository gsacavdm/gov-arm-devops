# Networking Azure Resource Manager Template

## Architecture
Sets up the following:
* Main VNet
  * DMZ Subnet & NSG
  * Middle Tier Subnet & NSG
  * ALM Tier Subnet & NSG
  * Data Tier Subnet & NSG
  * Management Tier Subnet & NSG

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_`, the vnet will be named `contoso_main_vnet` and the NSGs `contoso_dmz_nsg` and `contoso_alm_nsg`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Outstanding Items
* Implement NSG rules via `copy` and object variables.