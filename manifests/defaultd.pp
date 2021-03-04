# Deploy default.d files for nginx
define nginx::defaultd (
  $ensure  = 'present',
  $source  = ["puppet:///modules/site_nginx/${facts['networking']['fqdn']}/default.d/${name}.conf",
    "puppet:///modules/site_nginx/default.d/${name}.conf"],
  $content = false,
) {
  file { "/etc/nginx/default.d/${name}.conf":
    ensure  => $ensure,
    require => Package['nginx'],
    notify  => Exec['nginx_config_check'],
  }

  if $ensure == 'present' {
    File["/etc/nginx/default.d/${name}.conf"] {
      owner => root,
      group => 0,
      mode  => '0644'
    }
    if $content {
      File["/etc/nginx/default.d/${name}.conf"] {
        content => $content
      }
    } else {
      File["/etc/nginx/default.d/${name}.conf"] {
        source => $source
      }
    }
  }
}
