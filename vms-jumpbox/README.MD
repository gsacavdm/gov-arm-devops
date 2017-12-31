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
* VM Computer Names don't use the prefix given naming constraints.
* Diagnostics extension gathers logs and sends them to storage account.
  * Configuration must include ResourceId.
* Log Analytics (aka *OMS*) extensions sends logs from Diagnostics extension to Log Analytics.
  * Log Analytics deployment is not supported via Azure Resource Manager templates.
* Custom script extension disables IE ESC for the jumpbox.
  * Scripts pulled from open URI. Alternatively can use storage account & storage key.

## Outstanding Items
* Fix diagnostics extension
* Fix custom script extension - Should disable IE ESC
* Fix OMS extension
  * Make it conditional, install only if WorkspaceId & WorkspaceKey are provided

* Use `resourceId` and/or `reference` for boot diagnostics storage accounts
* Add support for resources in different resources groups
* Convert variables to objects and hardcode variables that are used only once
* Add support for multiple VMs through `copy` and `copyIndex()`