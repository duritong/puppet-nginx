# modules/nginx/manifests/init.pp - manage nginx stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class nginx {
  case $::operatingsystem {
    gentoo: { include nginx::gentoo }
    default: { include nginx::base }
  }
}
