# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile_dns_cache::service
class profile_dns_cache::service {

  ## KEEP THE UNBOUND SERVICE RUNNING

  service { 'unbound':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => [
      File['/etc/resolv.conf'],
      File['/etc/unbound/conf.d/unbound.conf'],
    ]
  }

  test_to_break_validation

  fubar

}

