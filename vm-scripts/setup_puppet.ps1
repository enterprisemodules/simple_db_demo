if ([System.IO.File]::Exists("$Env:LOCALAPPDATA\setup_puppet.done")) {
    Write-Output "Puppet already setup"
} else {
    #
    # Install R10K. We need this to download the correct set of puppet modules
    #
    Write-Output 'Installing required gems...'
    Invoke-Expression "& 'c:\Program Files\Puppet Labs\Puppet\puppet\bin\gem.bat' install r10k"
    Write-Output 'Installing required gems finished'


    Write-Output 'Installing required puppet modules...'
    [System.Environment]::SetEnvironmentVariable('SSL_CERT_DIR','C:\Program Files\Puppet Labs\Puppet\puppet\ssl\certs')
    [System.Environment]::SetEnvironmentVariable('SSL_CERT_FILE','C:\Program Files\Puppet Labs\Puppet\puppet\ssl\cert.pem')
    Set-Location 'c:\vagrant'
    $env:PATH += ';C:\Program Files\Git\bin'
    # Invoke-Expression "& 'c:\Program Files\Puppet Labs\Puppet\puppet\bin\r10k.bat' puppetfile install"
    Write-Output 'Installing required puppet modules finished.'

    #
    # Setup hiera search and backend. We need this to config our systems
    #
    Write-Output 'Setting up hiera directories'
    New-Item -Path "C:\ProgramData\PuppetLabs\code\environments\production\hieradata" -ItemType SymbolicLink -Value "c:\Vagrant\hieradata" -Force
    New-Item -Path "C:\ProgramData\PuppetLabs\code\environments\production\hiera.yaml" -ItemType SymbolicLink -Value "c:\Vagrant\hiera.yaml" -Force

    #
    # Configure the puppet path's
    #
    Write-Output 'Setting up Puppet module directories'
    New-Item -Path "C:\ProgramData\PuppetLabs\code\environments\production\modules" -ItemType SymbolicLink -Value "c:\Vagrant\modules" -Force

    Write-Output 'Setting up Puppet manifest directories'
    New-Item -Path "C:\ProgramData\PuppetLabs\code\environments\production\manifests" -ItemType SymbolicLink -Value "c:\Vagrant\manifests" -Force
    Write-Output 'Puppet setup completed.'

    #
    # Precompile .NET/powershell assemblies
    #
    Write-Output 'Precompiling .NET/powershell assemblies'
    $FrameworkDir=[Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()
    $NGENPath = Join-Path $FrameworkDir 'ngen.exe'

    [AppDomain]::CurrentDomain.GetAssemblies() |
        Where-Object Location -NotLike '' |
        Select-Object -ExpandProperty Location |
        ForEach-Object { & $NGENPath install """$_""" }

    [AppDomain]::CurrentDomain.GetAssemblies() |
        Where-Object Location -NotLike '' |
        Select-Object -ExpandProperty Location |
        ForEach-Object { & $NGENPath install """$_""" }

    New-Item -ItemType file $Env:LOCALAPPDATA\setup_puppet.done
}