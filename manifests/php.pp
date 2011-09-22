class php (
  $packages = [
    'php5',
    'php5-mysql',
    'php5-gd',
    'php-apc',
    'php5-curl',
    'php5-dev',
    'php5-dbg',
    'php-pear',
    'build-essential'
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
  ],
  $pecl_packages = [
    'uploadprogress'
  ],
  $development = False
) {
  package { $packages:
    ensure => installed,
  }

  pecl_package { $pecl_packages:
    
  }

  if $development {
    pecl_package { "xdebug": }
    conf_file { "conf.d/dev.ini":
      
    }
  }

  conf_file { $conf_files:
    require => Package['php5']
  }

  define conf_file() {
    file { "/etc/php5/${name}":
      owner => root,
      group => root,
      mode => 0444,
      source => "puppet:///modules/php/${name}",
      require => Package[$php::packages]
    }
  }

  define pecl_package() {
    exec { "pecl-install-${name}":
      command => "/usr/bin/pecl install $name",
      require => Package['php-pear', 'build-essential', 'php5-dev'],
      unless => "/usr/bin/test -n '/usr/bin/pecl list | grep $name'"
    }
  }
}
