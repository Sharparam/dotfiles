# Fix input/output encoding to be UTF-8
# This might not be needed on PowerShell Core?
#$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Set-PSReadlineOption -BellStyle None

#Get-Content -Path "$env:USERPROFILE\dotfiles\windows\aliases.ps1" -Raw | Invoke-Expression

Import-Module posh-git
