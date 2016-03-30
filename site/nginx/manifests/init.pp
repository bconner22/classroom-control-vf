class nginx {
  package {'nginx':
    ensure => installed,
  }
  case $osfamily { 
    'RedHat': {
      file {'/var/www':
        ensure => directory,
      }
      file {'/var/www/index.html': 
        ensure => present,
        source => 'puppet:///modules/nginx/index.html',
        
      }
      file {'/etc/nginx/nginx.conf':
        ensure => present,
        source => 'puppet:///modules/nginx/nginx.conf',
        notify => Service['nginx'],
        
      }
      file {'/etc/nginx/conf.d/default.conf':
        ensure => present,
        source => 'puppet:///modules/nginx/default.conf',
        notify  => Service['nginx'],
      }
    }
    'Debian': { notify {"not yet supported":} }
  }
  service {'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [File['/etc/nginx/conf.d/default.conf'], File['/etc/nginx/nginx.conf'], File['/var/www/index.html']],
  }  

}
