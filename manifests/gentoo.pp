class nginx::gentoo inherits nginx::base {
  Package[nginx]{
    category => 'www-servers',
  }
}
