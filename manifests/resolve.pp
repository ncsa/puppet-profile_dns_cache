# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile_dns_cache::resolve
class profile_dns_cache::resolve {

  ## CONFIGURE RESOLV.CONF

  file { '/etc/resolv.conf':
    ensure  => 'file',
    content => epp( 'profile_dns_cache/resolv.conf.epp' ),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
