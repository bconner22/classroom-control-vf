class nginx {
  case $osfamily { 
    'RedHat': { 
      $nginxuser = 'nginx'
      $nginxpackage = 'nginx'
      $nginxfileown = 'root'
      $nginxfliegrp = 'root'
      $docroot = '/var/www'
      $nginxconfigdir = '/etc/nginx'
      $nginxservblkdir = '/etc/nginx/conf.d'
      $nginxlogs = '/var/log/nginx'
    }
    'Debian': { 
      $nginxuser = 'www-data'
      $nginxpackage = 'nginx'
      $nginxfileown = 'root'
      $nginxfliegrp = 'root'
      $docroot = '/var/www'
      $nginxconfigdir = '/etc/nginx'
      $nginxservblkdir = '/etc/nginx/conf.d'
      $nginxlogs = '/var/log/nginx'
    }
    'Windows': { 
      $nginxpackage = 'nginx-service'
      $nginxfileown = 'Administrator'
      $nginxfliegrp = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $nginxconfigdir = 'C:/ProgramData/nginx'
      $nginxservblkdir = 'C:/ProgramData/nginx/conf.d'
      $nginxlogs = 'C:/ProgramData/nginx/logs'
      $nginxuser = 'nobody'
    }
    default: {
      fail("Operating system ${operatingsystem} is not supported.")
    }
      
  }  
  package {$nginxpackage :
    ensure => installed,
  }
  
  file {$docroot :
    ensure => directory,
  }
  file {"${docroot}/index.html": 
    ensure => present,
    source => 'puppet:///modules/nginx/index.html',
    
  }
  file {"${nginxconfigdir}/nginx.conf":
    ensure  => present,
    content  => template('nginx/nginx.conf.erb'),
    require => Package["${nginxpackage}"],
    notify  => Service['nginx'],
    
  }
  file {"${nginxservblkdir}/default.conf":
    ensure  => present,
    content  => template('nginx/default.conf.erb'),
    require => Package["${nginxpackage}"],
    notify  => Service['nginx'],
  }
    
    
  service {'nginx':
    ensure    => running,
    enable    => true,
    
  }  

}
