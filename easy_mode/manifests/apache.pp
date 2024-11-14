class apache {
  # Instala el paquete de Apache
  package { 'apache2':
    ensure => installed,
  }

  # Asegura que el servicio de Apache esté ejecutándose
  service { 'apache2':
    ensure    => running,
    enable    => true,
    require   => Package['apache2'],
  }

  # Crea el archivo index.html en la carpeta raíz de Apache
  file { '/var/www/html/index.html':
    ensure  => file,
    content => '<html><body><h1>Goal reached, the Apache web service is running.</h1></body></html>',
    require => Package['apache2'],
  }
}

# Indica que se debe aplicar la clase para que se ejecute
include apache