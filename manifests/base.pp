class nginx::base {
  package{'nginx':
    ensure => installed,
  }

  service{'nginx':
    ensure => running,
    enable => true,
    hasstatus => false, 
    require => Package[nginx],
  }

  file{nginx_config:
    path => '/etc/nginx/nginx.conf',
    source => [ "puppet:///modules/site_nginx/${::fqdn}/nginx.conf",
                "puppet:///modules/site_nginx/nginx.conf",
                "puppet:///modules/nginx/nginx.conf" ],
    owner => root,
    group => 0,
    mode => 0644,
    require => Package[nginx],
    notify => Service[nginx],
  }
}
