class nginx::params {
  case $osfamily { 
    'RedHat': { 
      $nginxuser = 'nginx'
      $nginxpackage = 'nginx'
      $nginxfileown = 'root'
      $nginxfilegrp = 'root'
      #$docroot = '/var/www'
      $nginxconfigdir = '/etc/nginx'
      $nginxservblkdir = '/etc/nginx/conf.d'
      $nginxlogs = '/var/log/nginx'
      $default_docroot = '/var/www'
    }
    'Debian': { 
      $nginxuser = 'www-data'
      $nginxpackage = 'nginx'
      $nginxfileown = 'root'
      $nginxfilegrp = 'root'
      #$docroot = '/var/www'
      $nginxconfigdir = '/etc/nginx'
      $nginxservblkdir = '/etc/nginx/conf.d'
      $nginxlogs = '/var/log/nginx'
      $default_docroot = '/var/www'
    }
    'Windows': { 
      $nginxpackage = 'nginx-service'
      $nginxfileown = 'Administrator'
      $nginxfilegrp = 'Administrators'
      #$docroot = 'C:/ProgramData/nginx/html'
      $nginxconfigdir = 'C:/ProgramData/nginx'
      $nginxservblkdir = 'C:/ProgramData/nginx/conf.d'
      $nginxlogs = 'C:/ProgramData/nginx/logs'
      $nginxuser = 'nobody'
      $default_docroot = 'C:/ProgramData/nginx/html'
    }
    default: {
      fail("Operating system ${operatingsystem} is not supported.")
    }
      
  }
}
