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

  if ( $profile_dns_cache::disable_unbound_anchor ) {
    file_line { 'disable unbound anchor':
      ensure   => 'present',
      after    => 'UNBOUND_OPTIONS',
      line     => 'DISABLE_UNBOUND_ANCHOR="yes"',
      match    => 'DISABLE_UNBOUND_ANCHOR',
      multiple => 'false',
      notify   => Service['unbound'],
      path     => '/etc/sysconfig/unbound',
    }
  } else {
    file_line { 'remove disable unbound anchor':
      ensure   => 'absent',
      line     => 'DISABLE_UNBOUND_ANCHOR="yes"',
      multiple => 'false',
      notify   => Service['unbound'],
      path     => '/etc/sysconfig/unbound',
    }
  }
}
