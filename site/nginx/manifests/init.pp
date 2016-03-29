class nginx {
  package {"nginx":
    ensure => installed,
  }
  case $os.family { 
    'Redhat' 



}
