# Contains all development specific stuff on vagrant boxes
class profile::base::vagrant {
  if $facts['kernel'] == 'Linux' {
    $required_packages = {
      'mlocate' => { ensure => 'present' },
      'unzip'   => { ensure => 'present' },
    }

    ensure_resources('package', $required_packages)

    swap_file::files { '8GB Swap':
      ensure       => present,
      swapfile     => '/var/swap.8gb',
      swapfilesize => '8GB',
    }
  } elsif $facts['kernel'] == 'Windows' {
    # For performance reasons in VirtualBox
    exec { 'disable windows defender':
      command  => 'Set-MpPreference -DisableArchiveScanning $true -DisableRealtimeMonitoring $true',
      provider => 'powershell',
      unless   => '$Preferences = Get-MpPreference; If ($Preferences.DisableArchiveScanning -eq $true -And $Preferences.DisableRealtimeMonitoring -eq $true) {exit 0} Else {exit 1}',
    }
  }
}
