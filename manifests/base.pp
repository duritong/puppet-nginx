# base installation
class nginx::base {
  package { 'nginx':
    ensure => installed,
  } -> file {
    default:
      owner => root,
      group => 0,
      mode  => '0644';
    ['/etc/nginx/include.d','/etc/nginx/vhosts.d']:
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      notify  => Service['nginx'];
    '/etc/nginx/conf.d/virtual.conf':
      ensure => file,
      notify => Service['nginx'];
  } -> file_line { 'load_nginx_vhosts':
    line => 'include /etc/nginx/vhosts.d/*.conf;',
    path => '/etc/nginx/conf.d/virtual.conf',
  } ~> service { 'nginx':
    ensure => running,
    enable => true,
  } ->  exec { 'reload_nginx':
    refreshonly => true,
    command     => '/usr/bin/systemctl reload nginx',
  }
}
