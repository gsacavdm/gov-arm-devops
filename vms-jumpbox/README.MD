# Jumpbox Virtual Machine Azure Resource Manager Template

## Architecture
Sets up the following:
* Jumpbox VM
  * VM
    * OS Disk
  * Network Interfaces
  * Diagnostics Storage Account
  * Public IP Address
  * Custom Script Extension to disable IE Enhanced Security Configuration (ESC)
  * Diagnostics Extension
  * Log Analytics (aka OMS) Extension
  * Azure Automation to turn off on schedule (alternative to Schedule which is available in Azure Gov)

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_vm_jumpbox` and `contoso_nic_jumpbox`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Other Notes
* VM Computer Names don't use the prefix given naming constraints.
* VM `storageProfile.osDisk.ostype` is hardcoded due to dependency on `osProfile.[windows/linux]Configuration`
* VM `diagnosticsProfile.bootDiagnostics.storageUri` is a reference, don't hardcode it.
* Extensions in general can be added at the root level or as child resources of VMs, opted for root level to reduce nesting.
* Diagnostics extension gathers logs and sends them to storage account.
  * Configuration must include ResourceId.
  * According to docs, can use XML but v1.9 assumes JSON, thus went with JSON.
  * `storageAccountEndpoint` is a reference, don't hardcode it.
  * v1.11 not available in Gov, had to use v1.9 (see [list of extension versions available in Gov](https://docs.microsoft.com/azure/azure-government/documentation-government-extension))
* Log Analytics (aka *OMS*) extensions sends logs from Diagnostics extension to Log Analytics.
  * Log Analytics deployment is not supported via Azure Resource Manager templates.
* Custom script extension disables IE ESC for the jumpbox.
  * Scripts pulled from open URI. Alternatively can use storage account & storage key.

## Outstanding Items
* Make OMS extension conditional, install only if WorkspaceId & WorkspaceKey are provided
* Add Azure Automation to turn off VM on schedule
* Add Recovery Services
* Add Alert rules

* Use `resourceId` and/or `reference` for boot diagnostics storage accounts
* Add support for resources in different resources groups
* Convert variables to objects and hardcode variables that are used only once
* Add support for multiple VMs through `copy` and `copyIndex()`