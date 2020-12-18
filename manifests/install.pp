# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile_dns_cache::install
class profile_dns_cache::install {

  ## INSTALL UNBOUND PACKAGE

  package { 'unbound':
    ensure => installed,
  }

}
