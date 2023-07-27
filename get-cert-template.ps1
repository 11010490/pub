$thumbprint = '1123123131213321'
Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Thumbprint -eq $thumbprint }

$certificate = Get-ChildItem -Path Cert:\LocalMachine\My | Select-Object -First 1
$templateName = $certificate.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Certificate Template Information" } | Select-Object -ExpandProperty Format(1)

if ($templateName -ne $null) {
    $templateName = $templateName.Substring(26)
    Write-Host "Certificate Template Name: $templateName"
} else {
    Write-Host "Certificate template information not found for the certificate."
}
