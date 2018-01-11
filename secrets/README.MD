# Secrets Azure Resource Manager Template

## Architecture
Sets up the following:
* Key Vault

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_automation`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Instructions
1. First, you'll need to setup the Azure AD entity that will have permissions to access Key Vault. For this example we'll create an Azure AD group and add the user to the group. We'll set the group with cert and secret admin permissions on the Vault. *Make sure you replace the values in \<brackets\> accordingly.

    `az ad group create --display-name 'KeyVault Admins' --mail-nickname 'KeyVaultAdmins'`

    Note the `objectId` of the group, you'll need this when you deploy the template.

    `az ad user list --upn <userUpn> --query [*][objectId]`
    `az ad group member add -g <groupObjectId> --member-id`

1. Create the resource group

    `az group create -n contoso-automation -l usgovvirginia`

1. Deploy the template to the newly created group

    `az group deployment create -g contoso-secrets -n $(date +%Y%m%d_%H%M%S) --template-file secrets/template.json`

1. You'll be prompted for the `AdminPolicyObjectId`. Enter the group's `objectId`.

1. Proceed to setup [Automation](../automation/README.MD).

## Other Notes

## Outstanding Items
