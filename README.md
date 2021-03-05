# profile_dns_cache
[![pdk-validate](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/pdk-validate.yml/badge.svg)](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/pdk-validate.yml) [![yamllint](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/yamllint.yml/badge.svg)](https://github.com/ncsa/puppet-profile_dns_cache/actions/workflows/yamllint.yml)

Installs unbound and configures DNS resolution.

## Reference
 
### class profile_dns_cache (
-  String $log_file,
-  String $local_domain,
-  Array $search_domains,
-  Array $forward_servers,
-  Array $backup_dns_servers,
-  Array $reverse_overrides,

See also: [REFERENCE.md](REFERENCE.md)
