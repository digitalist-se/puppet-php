class php::mongo () {
  php::pecl_package { "mongo": }

  file { "/etc/monit/monitrc":
    owner  => root,
    group  => root,
    mode   => 0700,
    content => "extension=mongo.so",
    require => php::pecl_package['mongo'],
  }

}
