package { 'apache2':
    ensure => installed,
}

package { 'php':
    ensure => installed,
    notify => Service['apache2'],
    require => [Package['apache2']],
}

# Define package for libapache2-mod-php
package { 'libapache2-mod-php':
  ensure => installed,
  notify => Service['apache2'],
  require => Package['apache2'],
}

# Define package for php-cli
package { 'php-cli':
  ensure => installed,
  require => Package['libapache2-mod-php'],
}

# Define package for php-mysql
package { 'php-mysql':
  ensure => installed,
  require => Package['php-cli'],
}

file { '/var/www/html/phpinfo.php':
    source => '/home/sethy/sy_inet4031_puppet_lab9/phpinfo.php',
    notify => Service['apache2'],
    require => [Package['apache2']]
}

service { 'apache2':
    ensure => running,
    enable => true,
    require => [Package['apache2'], Package['php']]

}

# Install MariaDB server package
package { 'mariadb-server':
  ensure => installed,
}

# Ensure MariaDB service is running and enabled
service { 'mysql':
  ensure => running,
  enable => true,
  require => Package['mariadb-server'],
}
