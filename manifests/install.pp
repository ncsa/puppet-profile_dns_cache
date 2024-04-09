#
# @summary Installs the unbound package
#
# @example
#   include profile_dns_cache::install
class profile_dns_cache::install {
  ## INSTALL UNBOUND PACKAGE

  package { 'unbound':
    ensure => installed,
  }
}
