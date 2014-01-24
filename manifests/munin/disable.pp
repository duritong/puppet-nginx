# remove munin status
class nginx::munin::disable {
  file_line{'remove_munin_line':
    ensure  => 'absent',
    line    => '        include /etc/nginx/include.d/munin.conf;',
    file    => '/etc/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'];
  }
}
