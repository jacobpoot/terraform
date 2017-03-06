# Terraform Azure AD Application Creation

param (

[string]$azurelocation = 'West Europe',
[string]$app_password = 'UYASDGas5dfaghuy&*YGusysd',
[string]$subscription_ID = '8c6f9e0e-915e-4898-b190-8494072467b2'

)

Add-AzureRmAccount
$azuresub = Get-AzureRmSubscription -SubscriptionId $subscription_ID

New-AzureRmADApplication -DisplayName TerraformAuth -HomePage http://azuregek.nl/TerraformAuth -IdentifierUris http://azuregek.nl/TerraformAuth -Password $app_password -Verbose

$app = Get-AzureRmADApplication -IdentifierUri http://azuregek.nl/TerraformAuth -Verbose

New-AzureRmADServicePrincipal -ApplicationId $app.ApplicationId -Verbose
Start-Sleep -Seconds 20
$roleassignment = New-AzureRmRoleAssignment -ServicePrincipalName http://azuregek.nl/TerraformAuth -RoleDefinitionName Owner -Scope /subscriptions/8c6f9e0e-915e-4898-b190-8494072467b2 -Verbose

$result = @{SubscriptionID="$($azuresub.SubscriptionId)"; TenantID = "$($azuresub.TenantId)"; ClientID = "$($app.ApplicationId)"; client_secret = $app_password; object_id = "$($roleassignment.ObjectId)"}
$result