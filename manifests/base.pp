# base installation
class nginx::base {
  package{'nginx':
    ensure => installed,
  }

  service{'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }
}
