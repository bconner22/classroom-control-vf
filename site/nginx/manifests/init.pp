class nginx (
  $package = $nginx::params::nginxpackage,
  $owner = $nginx::params::nginxfileown,
  $group = $nginx::params::nginxfilegrp,
  $docroot = $nginx::params::default_docroot,
  $confdir = $nginx::params::nginxconfigdir,
  $logdir = $nginx::params::nginxlogs,
  $user = $nginx::params::nginxuser,
  $root = undef,
) inherits nginx::params {

 
  File {
    owner => $nginxfileown,
    group => $nginxfilegrp,
    mode => '0664',
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
