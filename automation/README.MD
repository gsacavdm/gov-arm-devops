# Automation Azure Resource Manager Template

## Architecture
Sets up the following:

* Azure AD Service Principal - This has to be setup manually before setting up Azure Automation.

* Azure Automation
    * Azure Automation Account
    * Azure Run As Certificate
    * Azure Run As Connection
    * end-of-work-day Schedule
    * auto-shutdown Runbook

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_automation`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Instructions
1. In order for Azure Automation to perform Azure operations, it needs an Azure AD Service Principal.

    `az ad sp create-for-rbac -n contoso-automation --create-cert --keyvault contoso-vault --cert contoso-automation`

1. Note the `appId` of the service principal that was create, you'll need this for your parameters file.

1. Unlink other templates where we leverage the template's default parameter values or typed in values when prompted, we'll use a parameters file for this template. Copy the sample parameters file. The `-reference` file obtains the certificate used to authentication as the Azure AD service principal from Key Vault. The `-hardcoded` file requires that you manually download the cert (via `az keyvault secret download`) and input the base64Cert in there. We'll use the reference file:

    `cp automation/parameters-reference.json automation/parameters-reference.json.ignore`

1. Update the json.ignore file's `aaRunAsAppId` with the `appId` from the service principal you created.

1. Update the json.ignore file's `aaRunAsTenantId` with the `tenantId` from the following command:

    `az account show`

1. Update the json.ignore file's `aaRunAsCertThumbprint` with the `x509ThumbprintHex` from the following command:

    `az keyvault certificate show --vault-name contoso-vault -n contoso-automation`

1. Update the json.ignore file's `aaRunAsCertBase64Value.reference.keyVault.id`, specifically the `<subscriptionId>` with the `subscriptionId` from the following command:

    `az account show`

1. Now we are ready to deploy, create the resource group

    `az group create -n contoso-automation -l usgovvirginia`

1. Deploy the template to the newly created group

    `az group deployment create -g contoso-automation -n $(date +%Y%m%d_%H%M%S) --template-file automation/template.json --parameters automation/parameters-reference.json.ignore --parameter todayYYYY-MM-DD=$(date +%Y-%m-%d)`

1. The AzureRM modules that are setup by default in Azure Automation are old. You'll need to manually update them for now by going to portal, open the `contoso-automation` resource group, open the `contoso-automation` Automation Account resource, click on **Shared Resources > Modules** and click on **Update Azure Modules**.

1. Proceed to setup [Windows Jumpboxes](../vms-jumpbox-win/README.MD) or [Linux Jumpboxes](../vms-jumpbox-linux/README.MD)

## Other Notes
* AzureRM PS Module has to [be updated](https://docs.microsoft.com/azure/automation/automation-update-azure-modules)] as its old:
    * In Gov: 1.0.3
    * In Commercial: 3.1.0
    * Latest: 4.1.1
* Schedules are tricky
    * Start time needs to be in the future
* Job schedules are also tricky
    * Names need to be guids, used guid() function for that.
    * They don't do *upsert*, rather they fail if same job schedule exists.
* Run As Certificate and Credential have to be *AzureRunAsX* for the portal to show it correctly and other functionality (for example, *Update Azure Modules*) to work.

## Outstanding Items
* Make the following parameters references:
    * aaRunAsTenantId
    * aaRunAsCertThumbprint
    * SubscriptionId in aaRunAsCertBase64Value
* Add [job to update AzureRM modules](https://github.com/azureautomation/runbooks/blob/master/Utility/ARM/Update-ModulesInAutomationToLatestVersion.ps1)