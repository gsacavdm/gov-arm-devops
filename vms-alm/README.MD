# Application Lifecycle Management (ALM) Virtual Machines Azure Resource Manager Template

## Architecture
Sets up the following:
* Jenkins Master VM
  * VM
    * OS Disk
    * Data Disk
  * Network Interfaces
  * Diagnostics Storage Account
  * Availability Set
  * Public IP Address
  * Schedule - Not available in Azure Gov, replaced with Azure Automation

* Jenkins Slave VM
* TFS Svc VM
* TFS DB VM

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_`, the vms will be named `contoso_vm_jenkins_master` and `contoso_vm_tfs_svc`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Other Notes
* Hardcoded to disk type (Windows/Linux) given osProfile.(Windows/Linux)Configuration
* Reference for Boot Diagnostics Storage accounts
* Enable other Diagnostics?
* VM Computer Names don't use the prefix given naming constraints