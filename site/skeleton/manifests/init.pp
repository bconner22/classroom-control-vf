class skeleton {
  file {'/etc/skel' : 
    ensure => directory,
  
  }
  file {'/etc/skel/.bashrc':
    ensure => present,
    
    source => 'puppet:///site/skeleton/bashrc,

}
