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
  }
  exec{'add_munin_status':
    command => 'sed -i \'/^        server_name  _;$/a\\n        include /etc/nginx/include.d/munin.conf;\' /etc/nginx/nginx.conf',
    unless  => 'grep -q "/etc/nginx/include.d/munin.conf" /etc/nginx/nginx.conf',
    require => File['/etc/nginx/include.d/munin.conf'],
    notify  => Service['nginx'],
  }

  munin::plugin{ [ 'nginx_request', 'nginx_status' ]: }
}
