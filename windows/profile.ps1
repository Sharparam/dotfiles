# Available colors
# DarkBlue | DarkGreen | DarkCyan | DarkRed | DarkMagenta | DarkYellow |DarkGray
# Blue | Green | Cyan | Red | Magenta | Yellow | White | Gray | Black

$background = 'Black'

[console]::BackgroundColor = $background

# Main Colors
$host.UI.RawUI.ForegroundColor            = 'White'
$host.UI.RawUI.BackgroundColor            = $background

# Error, warning and debug colors
$host.PrivateData.ErrorForegroundColor    = 'Red'
$host.PrivateData.ErrorBackgroundColor    = $background

$host.PrivateData.WarningForegroundColor  = 'Yellow'
$host.PrivateData.WarningBackgroundColor  = $background

$host.PrivateData.DebugForegroundColor    = 'Gray'
$host.PrivateData.DebugBackgroundColor    = $background

$host.PrivateData.VerboseForegroundColor  = 'Gray'
$host.PrivateData.VerboseBackgroundColor  = $background

$host.PrivateData.ProgressForegroundColor = 'Gray'
$host.PrivateData.ProgressBackgroundColor = $background

# Syntax coloring and highlighting
#Set-PSReadlineOption -TokenKind Comment -ForegroundColor         Gray
#Set-PSReadlineOption -TokenKind Comment -BackgroundColor         $background

#Set-PSReadlineOption -TokenKind Keyword -ForegroundColor         DarkGreen
#Set-PSReadlineOption -TokenKind Keyword -BackgroundColor         $background

#Set-PSReadlineOption -TokenKind String -ForegroundColor          Gray
#Set-PSReadlineOption -TokenKind String -BackgroundColor          $background

#Set-PSReadlineOption -TokenKind Operator -ForegroundColor        White
#Set-PSReadlineOption -TokenKind Operator -BackgroundColor        $background

#Set-PSReadlineOption -TokenKind Variable -ForegroundColor        Green
#Set-PSReadlineOption -TokenKind Variable -BackgroundColor        $background

#Set-PSReadlineOption -TokenKind Command -ForegroundColor         White
#Set-PSReadlineOption -TokenKind Command -BackgroundColor         $background

#Set-PSReadlineOption -TokenKind Parameter -ForegroundColor       White
#Set-PSReadlineOption -TokenKind Parameter -BackgroundColor       $background

#Set-PSReadlineOption -TokenKind Type -ForegroundColor            Cyan
#Set-PSReadlineOption -TokenKind Type -BackgroundColor            $background

#Set-PSReadlineOption -TokenKind Number -ForegroundColor          Magenta
#Set-PSReadlineOption -TokenKind Number -BackgroundColor          $background

#Set-PSReadlineOption -TokenKind Member -ForegroundColor          Cyan
#Set-PSReadlineOption -TokenKind Member -BackgroundColor          $background

Set-PSReadlineOption -BellStyle None

#Clear-Host

Get-Content -Path "$env:USERPROFILE\dotfiles\windows\aliases.ps1" -Raw | Invoke-Expression

Unblock-File -Path ~/dotfiles/windows/ssh-agent-utils.ps1
. (Resolve-Path ~/dotfiles/windows/ssh-agent-utils.ps1)

Import-Module posh-git
