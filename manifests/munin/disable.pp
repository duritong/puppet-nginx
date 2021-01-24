# remove munin status
class nginx::munin::disable {
  file_line { 'munin_status':
    ensure  => 'absent',
    line    => '        include /etc/nginx/include.d/munin.conf;',
    path    => '/etc/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Exec['nginx_config_check'],
  }
}
