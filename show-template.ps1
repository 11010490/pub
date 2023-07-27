Get-ChildItem Cert:\CurrentUser\My | Where-Object {$_.Extensions | Where-Object {$_.oid.friendlyname -match "Certificate Template Information" -and $_.Format(0) -like "*YourTemplateName*}}
