# manage munin plugins for nginx
class nginx::munin {
  nginx::included{
    'munin':
      content => '# status for munin monitoring
location /nginx_status {
  stub_status on;    # activate stub_status module
  access_log  off;
  allow       127.0.0.1;   # restrict access to local only
  deny        all;
}';
  } -> file_line{'munin_status':
    line    => '        include /etc/nginx/include.d/munin.conf;',
    path    => '/etc/nginx/nginx.conf',
    after   => 'server_name  _',
    require => File['/etc/nginx/include.d/munin.conf'],
    notify  => Service['nginx'],
  } -> munin::plugin{ [ 'nginx_request', 'nginx_status' ]: }
}
