# Secrets Azure Resource Manager Template

## Architecture
Sets up the following:
* Key Vault

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_automation`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Other Notes

## Outstanding Items
* Add the following steps:

`az ad group create --display-name 'KeyVault Admins' --mail-nickname 'KeyVaultAdmins'`
More info on [az ad group create](https://docs.microsoft.com/cli/azure/ad/group?view=azure-cli-latest#az_ad_group_create)

`az ad user list --upn <userUpn> --query [*][objectId]`

`az ad group member add -g <groupObjectId> --member-id`
More info on [az ad group member add](https://docs.microsoft.com/cli/azure/ad/group/member?view=azure-cli-latest#az_ad_group_member_add)