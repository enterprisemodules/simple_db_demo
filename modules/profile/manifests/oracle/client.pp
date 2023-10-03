# This class will install a new ORACLE_HOME, so it can be patched
# before the databases are switched to it.
class profile::oracle::client (
) {
  easy_type::debug_evaluation() # Show local variable on extended debug

  echo { 'Ensure Client Software 19.0.0.0 in c:\oracle\client\19.0.0.0':
    withpath => false,
  }
  ora_install::client { 'Install client 19.0.0.0 into c:\oracle\\client\19.0.0.0':
    version                   => '19.0.0.0',
    file                      => 'WINDOWS.X64_193000_client_home.zip',
    oracle_base               => 'c:\\oracle',
    oracle_home               => 'c:\\oracle\\client\\19.0.0.0',
    db_port                   => 1521,
    user                      => 'oracle',
    user_base_dir             => 'c:\\Users',
    group                     => 'Adminitrators',
    group_install             => 'ORA_INSTALL',
    download_dir              => 'c:\\Temp',
    temp_dir                  => 'c:\\Temp',
    install_type              => 'Administrator',
    puppet_download_mnt_point => 'C:\\vagrant\\modules\\software\\files',
    bash_profile              => false,
  }
}
