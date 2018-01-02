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
* VM `diagnosticsProfile.bootDiagnostics.storageUri` is a reference implemented via the `reference` function to retreive the storage account's `primaryEndpoints.blob`.
* VM is deployed in vnet & subnets that are deployed separately, can be on same or different resource group. Implemented using `resourceId(subscriptionId,resourceGroupName,...)`. 
* Extensions in general can be added at the root level or as child resources of VMs, opted for root level to reduce nesting.
* Diagnostics extension gathers logs and sends them to storage account.
  * Configuration must include ResourceId.
  * According to docs, can use XML but v1.9 assumes JSON, thus went with JSON.
  * `storageAccountEndpoint` is a reference, don't hardcode it.
  * v1.11 not available in Gov, had to use v1.9 (see [list of extension versions available in Gov](https://docs.microsoft.com/azure/azure-government/documentation-government-extension))
* Log Analytics (aka *OMS*) extensions sends logs from Diagnostics extension to Log Analytics.
  * Log Analytics deployment is not supported via Azure Resource Manager templates.
  * The extension is only deployed if WorkspaceId and WorkspaceKey parameters are provided. Implemented using `condition`.
* Custom script extension disables IE ESC for the jumpbox.
  * Scripts pulled from open URI. Alternatively can use storage account & storage key.

## Outstanding Items
* Share Storage Account across VMs
* Add Azure Automation to turn off VM on schedule
* Add Recovery Services
* Add Alert rules

* Hardcode variables that are used only once
* Add support for multiple VMs through `copy` and `copyIndex()`