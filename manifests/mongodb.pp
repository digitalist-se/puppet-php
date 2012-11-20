class php::mongo () {
  php::pecl_package { "mongo": }

  file { "/etc/php5/conf.d/20-mongo.ini":
    owner  => root,
    group  => root,
    mode   => 0700,
    content => "extension=mongo.so",
    require => php::pecl_package['mongo'],
  }

}
