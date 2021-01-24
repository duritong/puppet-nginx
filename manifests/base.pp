# base installation
class nginx::base {
  package { 'nginx':
    ensure => installed,
  } -> file {
    default:
      owner  => root,
      group  => 0,
      mode   => '0644',
      notify => Exec['nginx_config_check'];
    ['/etc/nginx/include.d','/etc/nginx/vhosts.d']:
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true;
    '/etc/nginx/conf.d/virtual.conf':
      ensure => file;
  } -> file_line { 'load_nginx_vhosts':
    line   => 'include /etc/nginx/vhosts.d/*.conf;',
    path   => '/etc/nginx/conf.d/virtual.conf',
    notify => Exec['nginx_config_check'];
  # the file will be purged on next round, thus we will recheck the config
  } ~> exec { 'nginx_config_check':
    command     => 'nginx -t || (echo "invalid config found when checking" > /etc/nginx/vhosts.d/puppet_invalid_config && exit 1)',
    refreshonly => true,
  } ~> service { 'nginx':
    ensure => running,
    enable => true,
  } -> exec { 'reload_nginx':
    refreshonly => true,
    command     => '/usr/bin/systemctl reload nginx',
  }
}
