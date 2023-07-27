# Define the remote server's hostname or IP address
$remoteServer = "REMOTE_SERVER_NAME_OR_IP"

# Define the name of the certificate template
$certificateTemplateName = "RDPCert"

# Function to extract the thumbprint of the certificate generated from the specified template
function Get-CertificateThumbprintFromTemplate {
    param(
        [string]$templateName
    )
    # Get the certificates from the machine certificate store with the specified template name
    $certs = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Certificate Template Name" -and $_.Format(0) -eq $templateName } }

    # Return the first certificate thumbprint found (you can modify this if needed)
    if ($certs.Count -gt 0) {
        return $certs[0].Thumbprint
    } else {
        Write-Host "Certificate with template name '$templateName' not found."
        return $null
    }
}

# Step 1: Connect to the remote server
Enter-PSSession -ComputerName $remoteServer

# Step 2: Extract the SHA1 thumbprint for the certificate generated from the "RDPCert" template
$thumbprint = Get-CertificateThumbprintFromTemplate -templateName $certificateTemplateName

# Step 3: Set the Terminal Server service to use the extracted thumbprint with wmic
if ($thumbprint) {
    $cmd = "wmic /namespace:\\root\CIMV2\TerminalServices PATH Win32_TSGeneralSetting Set SSLCertificateSHA1Hash=`"$thumbprint`""
    Invoke-Expression $cmd
    Write-Host "Terminal Server service SSL certificate thumbprint set successfully."
} else {
    Write-Host "Could not set Terminal Server service SSL certificate thumbprint."
}

# Exit the remote session
Exit-PSSession
