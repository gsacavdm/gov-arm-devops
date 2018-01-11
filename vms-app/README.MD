# App Azure Resource Manager Template

## Architecture
Sets up the following:
* Oracle Database VM
  * VM
    * OS Disk
    * Data Disk
  * Network Interfaces
  * Diagnostics Storage Account
  * Custom Script Extension to disable IE Enhanced Security Configuration (ESC)
  * Diagnostics Extension
  * Log Analytics (aka OMS) Extension
  * Azure Automation to turn off on schedule (alternative to Schedule which is available in Azure Gov)

* JBOSS EAP Middle Tier VM
  
## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_app4_` will result in `contoso_app4_vm_db` and `contoso_app4_vm_mt`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.
