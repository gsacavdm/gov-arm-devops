# Shared PaaS Services Azure Resource Manager Template

## Architecture
Sets up the following:
* Azure Automation
  * Azure Automation Account
  * Azure Run As Certificate
  * Azure AD Service Principal - Setup separately from Azure Automation
  * Azure Run As Connection
  * end-of-work-day Schedule
  * auto-shutdown Runbook

* Log Analytics
  * Malware Assessment Solution
  * Upgrade Assessment Solution

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_automation`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Other Notes
* AzureRM PS Module has to [be updated(https://docs.microsoft.com/azure/automation/automation-update-azure-modules)] as its old in Gov:
  * In Gov: 1.0.3
  * In Commercial: 3.1.0
  * Latest: 4.1.1
* Job schedule names need to be guids, used guid() function for that.
* Job schedule start time needs to be in the future.

## Outstanding Items
* Azure Automation
  * Remove hardcoded parameters from job schedule
  * Add Run As Credential
  * Add job to update AzureRM modules
  * Decide approach for multiple VMs
    * 1 job per VM or multiple jobs per VMs
    * Hardcoded list or use tags
  * Setup Azure AD service principal & roles

*  Log Analytics
  * Instantiate via automation job (given lack of ARM support)
  * Setup OMS solutions