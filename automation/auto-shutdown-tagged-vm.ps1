Param(
    [Parameter(Mandatory=$true)]
    [String] $Subscription,

    [Parameter(Mandatory=$false)]
    [String] $Environment = "AzureCloud"
)

$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount `
    -ServicePrincipal `
    -Tenant $Conn.TenantID `
    -ApplicationId $Conn.ApplicationID `
    -CertificateThumbprint $Conn.CertificateThumbprint `
    -Environment $Environment `
    -Subscription $Subscription

Write-Output "Retrieving VMs"
$vms = Find-AzureRmResource -TagName Autoshutdown -TagValue yes

Write-Output "Iterating through VMs"
foreach ($vm in $vms) {
    Write-Output "Stopping ${$vm.ResourceGroupName}\${vm.ResourceName}"
    Stop-AzureRmVM `
		-Force `
		-Name $vm.ResourceName `
		-ResourceGroupName $vm.ResourceGroupName
        -AsJob
}