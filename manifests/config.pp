# @summary Configure unbound
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

  file { $profile_dns_cache::log_file:
    ensure  => file,
    owner   => 'unbound',
    group   => 'unbound',
    mode    => '0644',
    require => Package['unbound'],
  }

}
