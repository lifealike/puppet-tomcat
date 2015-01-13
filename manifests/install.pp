# == Class: tomcat::install
#
# install tomcat and logging stuff
#
class tomcat::install {

  package {'openjdk-7-jdk':
    ensure => present,
  }

  if !$tomcat::sources {
    package {"tomcat${tomcat::version}":
      ensure => present,
      require => Package['openjdk-7-jdk'],
    } ->
    file { '/usr/share/tomcat6/':
      ensure => directory,
    } ->
    class {'::tomcat::juli': } ->
    class {'::tomcat::logging': }

    if $::osfamily == 'RedHat' {
      class {'::tomcat::install::redhat': }
    }
  } else {
    class {'tomcat::source': }
  }
}
