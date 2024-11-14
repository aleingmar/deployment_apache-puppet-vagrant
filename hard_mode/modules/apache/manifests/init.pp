# Este archivo `site.pp` define la clase `apache`, que especifica el estado deseado para la instalación,
# configuración y gestión del servidor Apache en la máquina virtual.
# La clase `apache` garantiza que Apache esté instalado y en ejecución, y que se configure correctamente
# mediante un host virtual que redirija a los archivos especificados. Esta configuración también elimina
# el archivo de configuración predeterminado de Apache para evitar conflictos, y reemplaza su funcionalidad
# con una configuración personalizada.
# Además, asegura que el archivo `index.html` esté disponible en el directorio raíz y que el servicio
# Apache se recargue automáticamente si hay cambios en los archivos de configuración.

# Define la clase `apache` que instala, configura y gestiona el servidor Apache. 
# Definiendo todos los recursos necesarios para ello (o la mayoria que sean generales ya que estan en un modulo de apache)
# (Los que sean muy personalizados se definen en el manifiesto principal)

class apache {
  # Actualiza la lista de paquetes disponibles en el sistema, para asegurarse de que Apache se instale correctamente.
  exec { 'apt-update':
    command => '/usr/bin/apt-get update'  # Ejecuta el comando `apt-get update`. (se indica directorio del binario del comando)
  }
  
  # Establece una dependencia, indicando que cualquier instalación de paquetes (Package) debe realizarse después de `apt-update`. (se ejecuta antes el exec de aptupdate)
  Exec["apt-update"] -> Package <| |>

  # Asegura que el paquete `apache2` esté instalado en el sistema.
  package { 'apache2':
    ensure => installed,  # Garantiza que el paquete de Apache esté presente en el sistema.
  }

  # Elimina el archivo de configuración predeterminado de Apache para evitar conflictos con la configuración personalizada.
  file { '/etc/apache2/sites-enabled/000-default.conf': 
    ensure => absent,  # Asegura que este archivo no esté presente.
    require => Package['apache2'],  # Se asegura de que Apache esté instalado antes de eliminar el archivo.
  }

  # Crea un archivo de configuración personalizado para Apache en `sites-available`. Se usa debajo para el link simbolico
  file { '/etc/apache2/sites-available/vagrant.conf': 
    content => template('apache/virtual-hosts.conf.erb'),  # Usa una plantilla para el contenido del archivo.
    require => File['/etc/apache2/sites-enabled/000-default.conf'],  # Depende de que el archivo predeterminado esté ausente.
  }

  # Crea un enlace simbólico (fichero cuyo contenido apunta a otro) en `sites-enabled` que apunta a la configuración personalizada en `sites-available`.
  file { "/etc/apache2/sites-enabled/vagrant.conf":
    ensure  => link,  # Indica que este recurso es un enlace simbólico.
    target  => "/etc/apache2/sites-available/vagrant.conf",  # Enlace al archivo de configuración en `sites-available`.
    require => File['/etc/apache2/sites-available/vagrant.conf'],  # Asegura que el archivo exista antes de crear el enlace.
    notify  => Service['apache2'],  # Notifica al servicio de Apache para que se recargue tras cualquier cambio.
  }

  # Asegura que el archivo `index.html` esté presente en el directorio raíz de Apache.
  file { "${document_root}/index.html":
    ensure  => present,  # Garantiza que el archivo exista.
    source => 'puppet:///modules/apache/index.html',  # Especifica la ubicación del archivo en el módulo de Puppet. (como es un fichero no hace falta poner el /files)
    require => File['/etc/apache2/sites-enabled/vagrant.conf'],  # Solo se crea si la configuración de Apache está en su lugar.
    notify  => Service['apache2'],  # Notifica a Apache para recargar tras cualquier cambio en el archivo.
  }

  # Gestiona el servicio de Apache, asegurándose de que esté en ejecución y configurado para iniciarse al arrancar el sistema.
  service { 'apache2':
    ensure => running,  # Asegura que el servicio esté en ejecución.
    enable => true,  # Configura el servicio para iniciarse automáticamente con el sistema.
    hasstatus  => true,  # Permite a Puppet verificar el estado del servicio.
    restart => "/usr/sbin/apachectl configtest && /usr/sbin/service apache2 reload",  # Define el comando de reinicio para aplicar cambios.
  }
}


