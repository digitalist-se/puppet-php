define php::pecl_package() {
  exec { "pecl-install-${name}":
    command => "/usr/bin/pecl install $name",
    require => Package['php-pear', 'build-essential', 'php5-dev'],
    unless => "/usr/bin/test -n '/usr/bin/pecl list | grep $name'"
  }
}
