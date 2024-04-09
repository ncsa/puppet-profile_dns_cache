# @summary Configures /etc/resolv.conf and installs/configs unbound
#
# @author Based on work by Bill Glick; adapted by Jake Rundall.
#
# @example
#   include profile_dns_cache
#
# @param access_control
#   Configures access-control statements in unbound config. Used to control external access
#   when a host is setup to be an unbound server
#
#   Format is array of hashes of the form:
#   [ { net => 'NET_CIDR', action => 'ACTION' } , ... ]
#
#   Where NET_CIDR is an IP/mask, ex: 192.168.1.0/24
#
#   Where ACTION is any action allowed in unbound.conf, including :
#   deny, refuse, deny_non_local, refuse_non_local, allow, allow_setrd or allow_snoop.
#   See also `man unbound`
#   
#   Also controls iptables, access_controls that match any of the allow* actions get a firewall
#   rule added allowing the NET_CIDR given in `net`
#
#   Example hiera config
#   ```
#     ---
#     profile_dns_cache::access_control:
#       - net: "192.168.1.0/24"
#         action: "allow"
#       - net: "10.0.0.0/8"
#         action: "deny"
#   ```
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
# @param disable_unbound_anchor
#   Sets the unbound sysconfig startup setting 'DISABLE_UNBOUND_ANCHOR' to yes
#   or no
#
#   Default for DISABLE_UNBOUND_ANCHOR in no, so you will only see this
#   startup setting in /etc/sysconfig/unbound if you set it to true.
#
#   Note that in almost all cases you should leave this at the default of
#   false. Setting it to true should generally only be necessary if your DNS
#   servers do not support DNSSEC.
#
#   See also enable_harden_dnssec_stripped
#
# @param enable_harden_dnssec_stripped
#   Sets the unbound.conf global setting 'harden-dnssec-stripped' to yes or no
#
#   Default for unbound.conf is yes, so you will only see this config setting
#   in unbound.conf if you set it to false in hiera
#
#   Note that in almost all cases you should leave this at the default of true, otherwise
#   you weaken DNSSEC. Would only need it if you point to DNS servers that don't offer
#   all/any DNSSEC protections
#
#   See also disable_unbound_anchor
#
# @param forward_servers
#   List of servers unbound will forward to
#
#   Format is array of hashes of the form:
#   [ { server => 'IP_ADDRESS', comment => 'COMMENT' } , ... ]
#
# @param interfaces
#   Sets up unbound to listen for incoming connections from external hosts on
#   the interface(s) specified.
#
#   Format is array of one or more ip addresses
#
# @param local_domain
#   (optional) sets domain in resolv.conf, e.g., 'yahoo.com', or 'none' for none
#
# @param log_file
#   Path to unbound log file, e.g., '/var/log/unbound.log'
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
# @param search_domains
#   Sets search domains in resolv.conf, e.g., 'google.com'
#
class profile_dns_cache (
  # PARAMETERS
  Array   $access_control,
  Array   $backup_dns_servers,
  Boolean $disable_unbound_anchor,
  Boolean $enable_harden_dnssec_stripped,
  Array   $forward_servers,
  Array   $interfaces,
  String  $local_domain,
  String  $log_file,
  Array   $reverse_overrides,
  Array   $search_domains,
) {
  # SUB-MODULES TO INCLUDE
  include profile_dns_cache::config
  include profile_dns_cache::install
  include profile_dns_cache::resolv
  include profile_dns_cache::service

  # MAKE SURE backup_dns_servers HAS NO MORE THAN 2 SERVERS
  if $backup_dns_servers !~ Array[Hash, 0, 2] {
    fail('backup_dns_servers is not valid, please see init.pp for specification')
  }

  # Setup unbound server if required hiera variables are provided
  if ($access_control.empty) and ($interfaces.empty) {
    {} # do nothing
  } elsif (!$access_control.empty) and (!$interfaces.empty) {
    include profile_dns_cache::firewall
  } else {
    fail('Either profile_dns_cache::interfaces and profile_dns_cache::access_control must both be set or neither be set')
  }
}
