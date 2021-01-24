# Deploy vhosts.d files for nginx
define nginx::vhostsd (
  $ensure  = 'present',
  $source  = ["puppet:///modules/site_nginx/${facts['networking']['fqdn']}/vhosts.d/${name}.conf",
    "puppet:///modules/site_nginx/vhosts.d/${name}.conf"],
  $content = false,
) {
  file { "/etc/nginx/vhosts.d/${name}.conf":
    ensure => $ensure,
    notify => Exec['nginx_config_check'];
  }

  if $ensure == 'present' {
    File["/etc/nginx/vhosts.d/${name}.conf"] {
      owner => root,
      group => 0,
      mode  => '0644'
    }
    if $content {
      File["/etc/nginx/vhosts.d/${name}.conf"] {
        content => $content
      }
    } else {
      File["/etc/nginx/vhosts.d/${name}.conf"] {
        source => $source
      }
    }
  }
}
