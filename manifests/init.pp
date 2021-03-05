# @summary Configures /etc/resolv.conf and installs/configs unbound
#
# @author Based on work by Bill Glick; adapted by Jake Rundall.
#
# @example
#   include profile_dns_cache
#
# @param log_file
#   Path to unbound log file, e.g., '/var/log/unbound.log'
#
# @param local_domain
#   (optional) sets domain in resolv.conf, e.g., 'yahoo.com', or 'none' for none
#
# @param search_domains
#   Sets search domains in resolv.conf, e.g., 'google.com'
#
# @param forward_servers
#   List of servers unbound will forward to
#
#   Format is array of hashes of the form:
#   [ { server => 'IP_ADDRESS', comment => 'COMMENT' } , ... ]
#
# @param backup_dns_servers
#   Sets backup nameserver(s) in resolv.conf
#   
#   Format is array of hashes of the form:
#   [ { server => 'IP_ADDRESS', comment => 'COMMENT' } , ... ]
#   
#   Only the first two will be considered, any more will be ignored
#   as the max num of nameserver entries for resolv.conf is currently
#   3 and the first will be Unbound on the local server,
#   see http://man7.org/linux/man-pages/man5/resolv.conf.5.html
#
# @param reverse_overrides
#   Sets up an unbound local-zone and accompanying stub-zone to serve as an override
#   for reverse dns lookups
#
#   Array of arrays of the form:
#   [ [ 'STUB_ZONE_NAME', 'STUB-ADDR_FOR_ZONE' ] , ... ]
#
#   Each stub-zone can have one or more stub-addr(s) 
#
class profile_dns_cache (
  # PARAMETERS
  String $log_file,
  String $local_domain,
  Array $search_domains,
  Array $forward_servers,
  Array $backup_dns_servers,
  Array $reverse_overrides,
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

}
