$pfxpath = "$PSScriptRoot" + "\prtg07_ogd_nl.crt"
$pfxfile = Get-content -Path $pfxpath
Write-Host $pfxfile
$pfxfile = $pfxfile -replace "...........................$"
$pfxfile = $pfxfile -replace "$..........................."
Write-Host $pfxfile



#$secretvalue = ConvertTo-SecureString 'TOpdeskpassword' -AsPlainText -Force

<#
## TOPdesk PFX Passwords
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'pfx-top07-tas-nl-passphrase' -SecretValue $secretvalue
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'pfx-top07-tas-nl-passphrase' -SecretValue $secretvalue
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'pfx-top07-tas-nl-passphrase' -SecretValue $secretvalue

## TOPdesk PFX certs base64
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'pfx-top07-tas-nl' -SecretValue $secretvalue
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'pfx-top07-tas-nl' -SecretValue $secretvalue
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'pfx-top07-tas-nl' -SecretValue $secretvalue

## TOPdesk CRT certs 
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'crt-top07-tas-nl' -SecretValue $secretvalue
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'crt-top07-tas-nl' -SecretValue $secretvalue
$secret = Set-AzureKeyVaultSecret -VaultName 'terraform-secrets' -Name 'crt-top07-tas-nl' -SecretValue $secretvalue
#>


