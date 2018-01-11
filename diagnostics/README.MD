# Diagnostics Azure Resource Manager Template

## Architecture
Sets up the following:
* Diagnostics Storage Account

* Log Analytics
  * Malware Assessment Solution

## Naming Convention
This template only has 1 parameter: `naming_prefix`. This parameter is used to autogenerate the names of all resources. For example, for `naming_prefix` of `contoso_` will result in `contoso_automation`.

## Assumptions
All resources are created in the same location as the resource group they are contained in.

## Other Notes

## Outstanding Items
