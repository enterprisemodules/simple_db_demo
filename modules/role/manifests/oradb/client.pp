# Docs
class role::oradb::client {
  contain profile::base
  contain ora_profile::client

  Class['profile::base']
  -> Class['ora_profile::client']
}
