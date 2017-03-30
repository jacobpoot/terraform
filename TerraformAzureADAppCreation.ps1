# Terraform Azure AD Application Creation

param (

[string]$azurelocation = 'West Europe',
[string]$app_password = 'BAuygdiashdiuDUISjd',
[string]$subscription_ID = '03d914ad-63f7-4fab-b24e-7b56e7da5a56'

)

Add-AzureRmAccount
$azuresub = Get-AzureRmSubscription -SubscriptionId $subscription_ID

New-AzureRmADApplication -DisplayName TerraformAuth -HomePage http://ogd.nl/TerraformAuthBIR -IdentifierUris http://ogd.nl/TerraformAuthBIR -Password $app_password -Verbose

$app = Get-AzureRmADApplication -IdentifierUri http://ogd.nl/TerraformAuthBIR -Verbose

New-AzureRmADServicePrincipal -ApplicationId $app.ApplicationId -Verbose
Start-Sleep -Seconds 20
$roleassignment = New-AzureRmRoleAssignment -ServicePrincipalName http://ogd.nl/TerraformAuthBIR -RoleDefinitionName Owner -ResourceGroupName OGD-EUW-RGR-PRD-BIR-RAP-02  -Verbose
#$roleassignment = New-AzureRmRoleAssignment -ServicePrincipalName http://ogd.nl/TerraformAuthBIR -RoleDefinitionName Owner -Scope /subscriptions/03d914ad-63f7-4fab-b24e-7b56e7da5a56 -Verbose

$result = @{SubscriptionID="$($azuresub.SubscriptionId)"; TenantID = "$($azuresub.TenantId)"; ClientID = "$($app.ApplicationId)"; client_secret = $app_password; object_id = "$($roleassignment.ObjectId)"}
$result



# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "03d914ad-63f7-4fab-b24e-7b56e7da5a56"
  client_id       = "64b082e8-639e-42dd-97bb-34e4ed369b48"
  client_secret   = "BAuygdiashdiuDUISjd"
  tenant_id       = "afca0a52-882c-4fa8-b71d-f6db2e36058b"
}


terraform import azurerm_resource_group.mygroup /subscriptions/03d914ad-63f7-4fab-b24e-7b56e7da5a56/resourceGroups/OGD-EUW-RGR-PRD-BIR-RAP-01
