# Replace '1123123131213321' with the actual thumbprint of the certificate you want to query
$thumbprint = '1123123131213321'

# Get the certificate from the Local Machine store by thumbprint
$certificate = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Thumbprint -eq $thumbprint }

# Check if the certificate was found
if ($certificate -eq $null) {
    Write-Host "Certificate with thumbprint $thumbprint not found."
} else {
    # Get the certificate template information
    $templateName = $certificate.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Certificate Template Information" } | Select-Object -ExpandProperty Format(1)

    if ($templateName -ne $null) {
        # Extract the template name from the format string
        $templateName = $templateName.Substring(26)
        Write-Host "Certificate Template Name: $templateName"
    } else {
        Write-Host "Certificate template information not found for the certificate."
    }
}
