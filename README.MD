# Architecture Overview

* [Networking](/networking/README.md)
  * Main VNet
    * DMZ Subnet & NSG
    * Middle Tier Subnet & NSG
    * ALM Tier Subnet & NSG
    * Data Tier Subnet & NSG
    * Management Tier Subnet & NSG

* [Shared](/shared/README.md)
  * LogAnalytics
  * Azure Automation
  
* [AD](/vms-ad/README.md)
  * DC 1 VM
  * DC 2 VM

* [ALM](/vms-alm/README.md)
  * TFS Service VM
  * TFS Database VM
  * Jenkins Master VM
  * Jenkins Artifactory VM

* [Jumpbox](/vms-jumpbox/README.md)

* [App4](/vms-app4/README.md)
  * Middle-Tier JBoss EAP VM
  * Oracle Database VM

## Other Components
* Availability Set - Used on AD DC VMs
* Recovery Services Vault - Used on *persistent* VMs - AD VMs, TFS Database VM, Jenkins VMs, App4 DB VM.
* Extensions
  * Diagnostics extension
  * Log Analytics (aka *OMS*) extension
  * Custom script extension
* Load Balancers - To be used on App4 when a second Middle-Tier JBoss EAP VM is added
