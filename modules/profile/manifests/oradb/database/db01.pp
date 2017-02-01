# Docs
# TODO: Write documentation
class profile::oradb::database::db01(
  String $dbname,
  String $log_size,
  String $user_tablespace_size,
  String $system_tablespace_size,
  String $temporary_tablespace_size,
  String $undo_tablespace_size,
  String $sysaux_tablespace_size,
)
{
  profile::oradb::generic::database{$dbname:
    log_size                  => $log_size,
    user_tablespace_size      => $user_tablespace_size,
    system_tablespace_size    => $system_tablespace_size,
    temporary_tablespace_size => $temporary_tablespace_size,
    undo_tablespace_size      => $undo_tablespace_size,
    sysaux_tablespace_size    => $sysaux_tablespace_size,
  }

  ora_service {"${dbname}.example.com@${dbname}":       # Create a service with a name equal to the database
    ensure => 'present',
  }
}
