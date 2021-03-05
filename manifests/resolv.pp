#
# @summary Configures DNS using resolv.conf
#
# @example
#   include profile_dns_cache::resolve
class profile_dns_cache::resolv {

  ## CONFIGURE RESOLV.CONF

  file { '/etc/resolv.conf':
    ensure  => 'file',
    content => epp( 'profile_dns_cache/resolv.conf.epp' ),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
