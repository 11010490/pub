# List certificates installed in the LocalMachine store
$certs = Get-ChildItem -Path Cert:\LocalMachine\My

# Loop through each certificate and display its template name
foreach ($cert in $certs) {
    $templateName = $cert.Extensions | Where-Object { $_.Oid.FriendlyName -eq "Certificate Template Name" } | ForEach-Object { $_.Format(0) }
    if ($templateName) {
        Write-Host "Certificate Subject: $($cert.Subject)"
        Write-Host "Template Name: $templateName"
        Write-Host "--------------------------"
    }
}
