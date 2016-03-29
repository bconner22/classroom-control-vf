class nginx {
  package {'nginx':
    ensure => installed,
  }
  case $os.family { 
    'RedHat': {
      file {'/var/www':
        ensure => directory,
      }
      file {'/var/www/index.html': 
        ensure => present,
        source => 'puppet:///modules/nginx/index.html',
        notify => Service['nginx'],
      }
      file {'/etc/nginx/nginx.conf':
        ensure => present,
        source => 'puppet:///modules/nginx/nginx.conf',
        notify => Service['nginx'],
      }
      file {'/etc/nginx/conf.d/default.conf':
        ensure => present,
        source => 'puppet:///modules/nginx/default.conf',
        notify => Service['nginx'],
      }
    }
    'Debian': { notify {"not yet supported":} }
  }
  service {'nginx':
    ensure => running,
    enable => true,
  }  

}
