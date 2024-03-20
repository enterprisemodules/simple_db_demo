if ([System.IO.File]::Exists("$Env:LOCALAPPDATA\install_puppet.done")) {
    Write-Output "Puppet already installed"
} else {
    Write-Output 'Disable Security scanning...'
    Set-MpPreference -DisableArchiveScanning $true -DisableRealtimeMonitoring $true
    $uri = "https://downloads.puppetlabs.com/windows/puppet8/puppet-agent-x64-latest.msi"
    $out = "c:\windows\temp\puppet-agent-x64-latest.msi"
    Write-Output 'Downloading Puppet Agent...'
    Invoke-WebRequest -Uri $uri -OutFile $out
    Write-Output 'Installing Puppet Agent...'
    Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/qn /norestart /i $out" -wait
    Write-Output 'Puppet installed'
    Write-Output 'Installing Chocolatey'
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Output 'Chocolatey installed'
    Write-Output 'Installing git'
    $env:PATH += ';C:\ProgramData\chocolatey'
    Invoke-Expression "& choco install git -y --no-progress"
    Write-Output 'git installed'
    New-Item -ItemType file $Env:LOCALAPPDATA\install_puppet.done
}
