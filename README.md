# profile_dns_cache
[![pdk-validate](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/pdk-validate.yml/badge.svg)](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/pdk-validate.yml) [![yamllint](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/yamllint.yml/badge.svg)](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/yamllint.yml)

Installs unbound and configures DNS resolution, optionally sets up an unbound server to respond to external queries

## Reference
 
### class profile_dns_cache (
-  # PARAMETERS
-  Array   $access_control,
-  Array   $backup_dns_servers,
-  Boolean $enable_harden_dnssec_stripped,
-  Array   $forward_servers,
-  Array   $interfaces,
-  String  $local_domain,
-  String  $log_file,
-  Array   $reverse_overrides,
-  Array   $search_domains,

See also: [REFERENCE.md](REFERENCE.md)
