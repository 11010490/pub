$thumbprint = '1123123131213321'
Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Thumbprint -eq $thumbprint }

$certificate = Get-ChildItem -Path Cert:\LocalMachine\My | Select-Object -First 1
$templateName = $certificate.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Certificate Template Information" } | Select-Object -ExpandProperty Format(1)

# Check if the certificate was found
if ($certificate -eq $null) {
    Write-Host "Certificate with thumbprint $thumbprint not found."
} else {
    # Get the certificate template information
    $templateInfo = $certificate.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Certificate Template Information" }
    if ($templateInfo -ne $null) {
        # Extract the template name from the format string
        $templateName = $templateInfo.Format(1)
        Write-Host "Certificate Template Name: $templateName"
    } else {
        Write-Host "Certificate template information not found for the certificate."
    }
}
