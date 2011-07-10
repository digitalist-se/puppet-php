class php (
  $packages = [
    'php5',
    'php5-mysql',
    'php5-gd',
    'php-apc',
    'php5-curl',
    'php5-dev',
    'php5-dbg',
    'php5-xdebug'
  ],
  $conf_files = [
    'apache2/php.ini',
    'cli/php.ini',
    'conf.d/apc.ini',
    'conf.d/curl.ini',
    'conf.d/gd.ini',
    'conf.d/memcache.ini',
    'conf.d/mysqli.ini',
    'conf.d/mysql.ini',
    'conf.d/pdo.ini',
    'conf.d/pdo_mysql.ini',
    'conf.d/security',
    'conf.d/uploadprogress.ini',
    'conf.d/xdebug.ini'
  ]
) {
  package { $packages:
    ensure => installed,
  }

  conf_file { $conf_files:
    require => Package['php5']
  }

  define conf_file() {
    file { "/etc/php5/${name}":
      owner => root,
      group => root,
      mode => 0444,
      source => "puppet:///php/${name}"
    }
  }
}
