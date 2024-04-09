class { 'profile_dns_cache':
  log_file           => '/var/log/unbound.log',
  local_domain       => 'foo.com',
  search_domains     => ['foo.com', 'goo.com'],
  forward_servers    => [
    { server => '8.8.8.8', comment => 'Google primary' },
    { server => '8.8.4.4', comment => 'Google secondary' },
    { server => '84.200.69.80', comment => 'DNS.WATCH primary' },
    { server => '84.200.70.40', comment => 'DNS.WATCH secondary' },
  ],
  backup_dns_servers => [
    { server => '8.8.8.8', comment => 'Google primary' },
    { server => '84.200.69.80', comment => 'DNS.WATCH primary' },
  ],
  reverse_overrides  => [
    ['192.10.in-addr.arpa.', '10.192.1.2'],
    ['10.in-addr.arpa.', '10.1.1.2']
  ],
}
