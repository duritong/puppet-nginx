# manage nginx stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
#
#  Parameters:
#
#    * manage_shorewall_http:  Open http port with shorewall?
#    * manage_shorewall_https: Open https port with shorewall?
#
class nginx (
  Boolean $manage_shorewall_http  = false,
  Boolean $manage_shorewall_https = false,
  Boolean $use_munin = false,
  Hash $vhosts = {},
  Hash $confs = {},
) {
  include nginx::base

  if $manage_shorewall_http {
    include shorewall::rules::http
  }
  if $manage_shorewall_https {
    include shorewall::rules::https
  }

  if $use_munin {
    include nginx::munin
  } else {
    include nginx::munin::disable
  }

  if $facts['os']['selinux']['enabled'] {
    include nginx::selinux
  }
  create_resources('nginx::vhostsd',$vhosts)
  create_resources('nginx::confd',$confs)
}
