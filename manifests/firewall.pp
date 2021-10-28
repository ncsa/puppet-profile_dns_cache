# @summary Open firewall when unbound is being setup as a server
#
# Open firewall when unbound is being setup as a server
#
class profile_dns_cache::firewall {

  $access_control = lookup('profile_dns_cache::access_control')

  $access_control.each | $acl | {

    # Only open firewall if the acl rule is an allow rule
    if $acl[action] =~ /^allow/ {
      firewall {
        "210 allow unbound tcp from ${acl[net]}" :
          action => 'accept',
          dport  => '53',
          proto  => 'tcp',
          source => $acl[net],
      }

      firewall {
        "210 allow unbound udp from ${acl[net]}" :
          action => 'accept',
          dport  => '53',
          proto  => 'udp',
          source => $acl[net],
      }
    }
  }

}
