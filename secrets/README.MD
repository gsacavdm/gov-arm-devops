Ensure enableForDeployment is true

`az ad group create --display-name 'KeyVault Admins' --mail-nickname 'KeyVaultAdmins'`
More info on [az ad group create](https://docs.microsoft.com/cli/azure/ad/group?view=azure-cli-latest#az_ad_group_create)

`az ad user list --upn <userUpn> --query [*][objectId]`

`az ad group member add -g <groupObjectId> --member-id`
More info on [az ad group member add](https://docs.microsoft.com/cli/azure/ad/group/member?view=azure-cli-latest#az_ad_group_member_add)