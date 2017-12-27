# Jumpbox Virtual Machine Azure Resource Manager Template

## Architecture
Sets up the following:
* Jumpbox VM
  * VM
    * OS Disk
  * Network Interfaces
  * Diagnostics Storage Account
  * Public IP Address
  * Schedule - Not available in Azure Gov, replaced with Azure Automation

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_vm_jumpbox` and `contoso_nic_jumpbox`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Other Notes
* Hardcoded to disk type (Windows/Linux) given osProfile.(Windows/Linux)Configuration
* Reference for Boot Diagnostics Storage accounts
* Enable other Diagnostics?
* VM Computer Names don't use the prefix given naming constraints