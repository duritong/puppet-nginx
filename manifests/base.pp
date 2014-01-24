# base installation
class nginx::base {
  package{'nginx':
    ensure => installed,
  }

  file{
    ['/etc/nginx/include.d','/etc/nginx/vhosts.d' ]:
      ensure  => directory,
      owner   => root,
      group   => 0,
      mode    => '0644',
      recurse => true,
      purge   => true,
      force   => true,
      require => Package['nginx'],
      notify  => Service['nginx'];
  }

  file_line{'load_nginx_vhosts':
    line    => 'include /etc/nginx/vhosts.d/*.conf;',
    path    => '/etc/nginx/conf.d/virtual.conf',
    require => Package['nginx'],
    notify  => Service['nginx'];
  }

  service{'nginx':
    ensure  => running,
    enable  => true,
  }
}
