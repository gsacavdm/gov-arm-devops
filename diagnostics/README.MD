# Diagnostics Azure Resource Manager Template

## Architecture
Sets up the following:
* Diagnostics Storage Account

* Log Analytics
      * Malware Assessment Solution

## Naming Convention
This template only has 1 parameter: `namingPrefix`. This parameter is used to autogenerate the names of all resources. For example, for `namingPrefix` of `contoso_` will result in `contoso_automation`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Instructions
1. Create the resource group

    `az group create -n contoso-diagnostics -l usgovvirginia`

1. Deploy the template to the newly created group

    `az group deployment create -g contoso-diagnostics -n $(date +%Y%m%d_%H%M%S) --template-file diagnostics/template.json`

1. Proceed to setup [Secrets](../secrets/README.MD).

## Other Notes

## Outstanding Items
