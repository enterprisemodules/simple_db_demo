# Docs
class role::oradb::simple_client()
{

  contain ::profile::base
  contain ::profile::oracle::client

  Class['::profile::base']
  -> Class['::profile::oracle::client']
}
