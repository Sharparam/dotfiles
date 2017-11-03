[console]::BackgroundColor = "DarkMagenta"

Get-Content -Path "$env:USERPROFILE\dotfiles\windows\aliases.ps1" -Raw | Invoke-Expression

Clear-Host
