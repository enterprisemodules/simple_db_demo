if ([System.IO.File]::Exists("$Env:LOCALAPPDATA\install_modules.done")) {
    Write-Output "Modules already installed"
} else {
    Write-Output 'Installing required puppet modules...'
    Set-Location 'c:\vagrant'
    Invoke-Expression "& 'c:\Program Files\Puppet Labs\Puppet\puppet\bin\r10k.bat' puppetfile install --verbose"
    Write-Output 'Installing required puppet modules finished.'
    New-Item -ItemType file $Env:LOCALAPPDATA\install_modules.done
}