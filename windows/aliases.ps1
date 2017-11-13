function Cake-Init {
    Invoke-WebRequest https://cakebuild.net/download/bootstrapper/windows -OutFile build.ps1
}

New-Alias Cake .\build.ps1

New-Alias ssh "$env:PROGRAMFILES\Git\usr\bin\ssh.exe"
New-Alias ssh-agent "$env:PROGRAMFILES\Git\usr\bin\ssh-agent.exe"
New-Alias ssh-add "$env:PROGRAMFILES\Git\usr\bin\ssh-add.exe"
