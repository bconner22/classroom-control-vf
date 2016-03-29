class memcached {
  package {'memcached': 
    ensure => installed,
  }
  file {'/etc/sysconfig/memcached':
    ensure => present,
    source => 'puppet:///modules/memcached/memcached',
  }


}
