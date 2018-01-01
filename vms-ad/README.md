# Active Directory Azure Resource Manager Template

## Architecture
Sets up the following:
* AD Domain Controller VM
  * VM
    * OS Disk
  * Network Interfaces
  * Diagnostics Storage Account
  * Custom Script Extension to disable IE Enhanced Security Configuration (ESC)
  * Diagnostics Extension
  * Log Analytics (aka OMS) Extension
  * Azure Automation to turn off on schedule (alternative to Schedule which is available in Azure Gov)
  
## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_vm_dc` and `contoso_nic_dc`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.
