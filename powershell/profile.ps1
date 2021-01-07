# Fix input/output encoding to be UTF-8
# This might not be needed on PowerShell Core?
#$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Set-PSReadlineOption -BellStyle None

#Get-Content -Path "$env:USERPROFILE\dotfiles\windows\aliases.ps1" -Raw | Invoke-Expression

Import-Module posh-git
#Import-Module oh-my-posh
#Set-Theme Paradox
Invoke-Expression (&starship init powershell)

$DEFAULT_PGP_KEYID = 'C58C41E27B00AD04'

function Send-Key() {
    [CmdletBinding()]
    param (
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        [string]
        $KeyId = $DEFAULT_PGP_KEYID,

        [Parameter()]
        [bool]
        $PublishToOpenPGP = $true,

        [Parameter()]
        [bool]
        $PublishToKeybase = $true
    )

    Write-Host "Publishing PGP key $KeyId to keyservers"

    Write-Host "Publishing to default keyserver"
    & gpg --send-key "$KeyId"
    Write-Host "Publishing to MIT keyserver"
    & gpg --keyserver pgp.mit.edu --send-key "$KeyId"
    Write-Host "Publishing to GnuPG keyserver"
    & gpg --keyserver keys.gnupg.net --send-key "$KeyId"
    Write-Host "Publishing to Ubuntu keyserver"
    & gpg --keyserver hkps://keyserver.ubuntu.com:443 --send-key "$KeyId"

    if ($KeyId -eq $DEFAULT_PGP_KEYID) {
        if ($PublishToOpenPGP) {
            Write-Host "Publishing key to keys.openpgp.org, this will require verification!"
            gpg --export $KeyId | curl -T - https://keys.openpgp.org
        }

        $hasKeybase = Get-Command 'keybase' -ErrorAction SilentlyContinue
        if ($PublishToKeybase -And $hasKeybase) {
            Write-Host "Publishing key to Keybase"
            $fp = $(& gpg --with-colons --fingerprint "$KeyId") |
                Where-Object { $_ -match 'fpr' } |
                ForEach-Object { ($_ -split ':')[9] } |
                Select-Object -First 1
            Write-Host "Publishing fingerprint $fp to Keybase"
            & keybase pgp update "$fp"
        }
    }

    Write-Host "Publishing of PGP key $KeyId completed!"
}
