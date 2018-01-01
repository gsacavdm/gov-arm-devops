Param(
    [Parameter(Mandatory=$true)]
    [String] $Subscription,

    [Parameter(Mandatory=$true)]
    [String] $ResourceGroup,

    [Parameter(Mandatory=$true)]
    [String] $VmName,

    [Parameter(Mandatory=$false)]
    [String] $Environment = "AzureCloud",
)

$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount `
    -ServicePrincipal `
    -Tenant $Conn.TenantID `
    -ApplicationId $Conn.ApplicationID `
    -CertificateThumbprint $Conn.CertificateThumbprint `
    -Environment $Environment `
    -Subscription $Subscription

Stop-AzureRmVM `
		-Force `
		-Name $VmName `
		-ResourceGroupName $ResourceGroup