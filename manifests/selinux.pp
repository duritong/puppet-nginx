# manage selinux bits
class nginx::selinux {
  selboolean{
    'httpd_setrlimit':
      value      => 'on',
      persistent => true,
  }
}
