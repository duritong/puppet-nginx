# Deploy conf.d files for nginx
define nginx::confd(
  $ensure  = 'present',
  $source  = [ "puppet:///modules/site_nginx/${::fqdn}/conf.d/${name}.conf",
              "puppet:///modules/site_nginx/conf.d/${name}.conf" ],
  $content = false,
){
  file{"/etc/nginx/conf.d/${name}.conf":
    ensure  => $ensure,
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  if $ensure == 'present' {
    File["/etc/nginx/conf.d/${name}.conf"]{
      owner => root,
      group => 0,
      mode  => '0644'
    }
    if $content {
      File["/etc/nginx/conf.d/${name}.conf"]{
        content => $content
      }
    } else {
      File["/etc/nginx/conf.d/${name}.conf"]{
        source => $source
      }
    }
  }
}
