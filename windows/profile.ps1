# Available colors
# DarkBlue | DarkGreen | DarkCyan | DarkRed | DarkMagenta | DarkYellow |DarkGray 
# Blue | Green | Cyan | Red | Magenta | Yellow | White | Gray | Black

[console]::BackgroundColor = "DarkGray"

# Main Colors
$host.UI.RawUI.ForegroundColor            = 'White'
$host.UI.RawUI.BackgroundColor            = 'DarkGray'

# Error, warning and debug colors
$host.PrivateData.ErrorForegroundColor    = 'Red'
$host.PrivateData.ErrorBackgroundColor    = 'DarkGray'

$host.PrivateData.WarningForegroundColor  = 'Yellow'
$host.PrivateData.WarningBackgroundColor  = 'DarkGray'

$host.PrivateData.DebugForegroundColor    = 'Gray'
$host.PrivateData.DebugBackgroundColor    = 'DarkGray'

$host.PrivateData.VerboseForegroundColor  = 'Gray'
$host.PrivateData.VerboseBackgroundColor  = 'DarkGray'

$host.PrivateData.ProgressForegroundColor = 'Gray'
$host.PrivateData.ProgressBackgroundColor = 'DarkGray'

# Syntax coloring and highlighting
Set-PSReadlineOption -TokenKind Comment -ForegroundColor         Gray
Set-PSReadlineOption -TokenKind Comment -BackgroundColor         DarkGray

Set-PSReadlineOption -TokenKind Keyword -ForegroundColor         DarkGreen
Set-PSReadlineOption -TokenKind Keyword -BackgroundColor         DarkGray

Set-PSReadlineOption -TokenKind String -ForegroundColor          Gray
Set-PSReadlineOption -TokenKind String -BackgroundColor          DarkGray

Set-PSReadlineOption -TokenKind Operator -ForegroundColor        White
Set-PSReadlineOption -TokenKind Operator -BackgroundColor        DarkGray

Set-PSReadlineOption -TokenKind Variable -ForegroundColor        Green
Set-PSReadlineOption -TokenKind Variable -BackgroundColor        DarkGray

Set-PSReadlineOption -TokenKind Command -ForegroundColor         White
Set-PSReadlineOption -TokenKind Command -BackgroundColor         DarkGray

Set-PSReadlineOption -TokenKind Parameter -ForegroundColor       White
Set-PSReadlineOption -TokenKind Parameter -BackgroundColor       DarkGray

Set-PSReadlineOption -TokenKind Type -ForegroundColor            Cyan
Set-PSReadlineOption -TokenKind Type -BackgroundColor            DarkGray

Set-PSReadlineOption -TokenKind Number -ForegroundColor          Magenta
Set-PSReadlineOption -TokenKind Number -BackgroundColor          DarkGray

Set-PSReadlineOption -TokenKind Member -ForegroundColor          Cyan
Set-PSReadlineOption -TokenKind Member -BackgroundColor          DarkGray

Get-Content -Path "$env:USERPROFILE\dotfiles\windows\aliases.ps1" -Raw | Invoke-Expression

Clear-Host
