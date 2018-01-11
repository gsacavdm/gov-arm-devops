# About
* This tutorial uses the Azure CLI (though you can also use AzureRM PowerShell module.)

    `az cloud set -n AzureUSGovernment`
    `az login`

    * The general paradigm involves creating a resource group and then creating a deployment. For every deployment you can use the `--no-wait` parameter to make the operation asynchronous and check the status of the deployment in the portal (Open the resource group and open the Deployments blade).

* To edit the templates, use Visual Studio Code & install Azure Resource Manager Tools.
    * Note: There's lag in intellisense, sometimes you'll get errors that aren't real. For example:
        * `guid()` isn't recognized by intellisense but it does exist.
    * Runbook schema is out of date, it complains about missing jobScheduledId.
    * [Azure Resource Manager reference](https://docs.microsoft.com/azure/templates/)

# Architecture Overview

* [Network](/network/README.MD)
    * Main VNet
        * DMZ Subnet & NSG
        * Middle Tier Subnet & NSG
        * ALM Tier Subnet & NSG
        * Data Tier Subnet & NSG
        * Management Tier Subnet & NSG

* [Diagnostics](/diagnostics/README.MD)
    * Diagnostics Storage Account
    * Log Analytics

* [Secrets](/secrets/README.MD)
    * Key Vault
  
* [Automation](/automation/README.MD)
    * Azure Automation

* [Windows Jumpbox VM](/vms-jumpbox-win/README.MD)
* [Linux Jumpbox VM](/vms-jumpbox-linux/README.MD)
  
* [AD](/vms-ad/README.MD)(**PENDING**)
    * DC 1 VM
    * DC 2 VM

* [ALM](/vms-alm/README.MD) (**Work in Progress**)
    * TFS Service VM
    * TFS Database VM
    * Jenkins Master VM
    * Jenkins Artifactory VM

* [App](/vms-app/README.MD) (**PENDING**)
    * Middle-Tier JBoss EAP VM
    * Oracle Database VM

## Other Components
* Availability Set - Used on AD DC VMs
* Recovery Services Vault - Used on *persistent* VMs - AD VMs, TFS Database VM, Jenkins VMs, App4 DB VM.
* Extensions
    * Diagnostics extension
    * Log Analytics (aka *OMS*) extension
    * Custom script extension
* Load Balancers - To be used on App when a second Middle-Tier JBoss EAP VM is added
