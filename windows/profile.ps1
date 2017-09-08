[console]::BackgroundColor = "DarkMagenta"

function Cake-Init {
    Invoke-WebRequest https://cakebuild.net/download/bootstrapper/windows -OutFile build.ps1
}

New-Alias Cake .\build.ps1

Clear-Host
