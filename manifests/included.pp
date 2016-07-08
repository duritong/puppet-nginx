# Deploy include.d files for nginx
define nginx::included(
  $ensure  = 'present',
  $source  = ["puppet:///modules/site_nginx/${::fqdn}/include.d/${name}.conf",
              "puppet:///modules/site_nginx/include.d/${name}.conf" ],
  $content = false,
){
  file{"/etc/nginx/include.d/${name}.conf":
    ensure => $ensure,
    notify => Service['nginx'],
  }

  if $ensure == 'present' {
    File["/etc/nginx/include.d/${name}.conf"]{
      owner => root,
      group => 0,
      mode  => '0644'
    }
    if $content {
      File["/etc/nginx/include.d/${name}.conf"]{
        content => $content
      }
    } else {
      File["/etc/nginx/include.d/${name}.conf"]{
        source => $source
      }
    }
  }
}
