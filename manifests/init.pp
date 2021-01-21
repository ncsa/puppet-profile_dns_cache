# A description of what this class does
#   # Based on work by Bill Glick; adapted by Jake Rundall.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile_dns_cache
class profile_dns_cache (
  # PARAMETERS
  $log_file,            # e.g., '/var/log/unbound.log'
  $local_domain,        # (optional) single domain, e.g., 'yahoo.com', or 'none' for none
  $search_domains,      # array of domains, e.g., 'google.com'
  $forward_servers,     # servers that Unbound will forward to
                        # array of hashes of the form
                        #   { server => '<ip address>', comment => '<comment>'},
  $backup_dns_servers,  # array of hashes of the form
                        #   { server => '<ip address>', comment => '<comment>'},
                        #   only the first two will be considered; any more will be ignored
                        #   as the max num of nameserver entries for resolv.conf
                        #   is currently 3 and the first will be Unbound on the local server;
                        #   see http://man7.org/linux/man-pages/man5/resolv.conf.5.html
  $reverse_overrides,
)
{

  # SUB-MODULES TO INCLUDE
  include profile_dns_cache::config
  include profile_dns_cache::install
  include profile_dns_cache::resolv
  include profile_dns_cache::service

  # MAKE SURE backup_dns_servers HAS NO MORE THAN 2 SERVERS
  if $backup_dns_servers !~ Array[Hash, 0, 2] {
      fail('backup_dns_servers is not valid, please see init.pp for specification')
  }

# THE FOLLOWING IS A TEST OF GITHUB ACTIONS AND CODE SCANNERS
      INCLUDE ::TEST

THIS IS A BROKEN CODE

VARIABLE1=123
VARIABLE2='123'
VARIABLE3="123"

}
