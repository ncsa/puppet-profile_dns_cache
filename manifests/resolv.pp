#
# @summary Configures DNS using resolv.conf
#
# @example
#   include profile_dns_cache::resolve
class profile_dns_cache::resolv {

  ## CONFIGURE RESOLV.CONF
  ## Symlink resolv.conf to stop NetworkManager from meddling
  ## Reference: SVCPLAN-1814

  file { '/etc/resolv.conf.unbound':
    ensure  => 'file',
    content => epp( 'profile_dns_cache/resolv.conf.epp' ),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/resolv.conf':
    ensure  => 'link',
    target   => '/etc/resolv.conf.unbound',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/resolv.conf.unbound'],
  }

}
