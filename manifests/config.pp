# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile_dns_cache::config
class profile_dns_cache::config {

  # CONFIGURE UNBOUND SERVICE 

  file { '/etc/unbound/conf.d/unbound.conf':
    ensure  => file,
    content => epp( 'profile_dns_cache/unbound.conf.epp' ),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['unbound'],
  }

  file { $unbound::log_file:
    ensure  => file,
    owner   => 'unbound',
    group   => 'unbound',
    mode    => '0644',
    require => Package['unbound'],
  }

}
