**Despliegue Automatizado de Servidor Web con Vagrant y Puppet**

Este proyecto lo desarrollé para la asignatura de Automatización de Despliegues, dentro del máster en Desarrollo y Operaciones.

El objetivo de este proyecto era desplegar y configurar de forma automatizada un entorno web basado en una máquina virtual con un apache y una pequeña página web en su interior. 
La máquina virtual es levantada por IaC con Vagrant y para su aprovisionamiento, Puppet gestiona la instalación del servidor Apache y la carga automática de un archivo HTML simple, creando así un servicio web listo para usarse.

El directorio se compone de un directorio donde se encuentra un fichero "Vagrantfile" y una carpeta "manifests" en cuyo interior se encuentra el fichero "apache.pp".

- En el Vagrantfile se define la infraestructura de Mv´s que es necesaria desplegar para componer el servicio web. De esto se encarga Vagrant y por debajo usa como proveedor de virtualización VirtualBox.
 - En el Vagrantfile, antes de indicarle a Vagrant que debe hacer aprovisionamiento usando Puppet, se ejecuta un script para instalar Puppet que trabaja en modo stand-alone (sin seguir modelo cliiente-servidor).

- En el fichero "apache.pp" se define la configuración de esta infraestructura, y le sirve a Puppet de guía declarativa para desarrollar su trabajo. (Como Puppet usa un lenguaje declarativo no se le indica como quiere que se consigan las cosas, si no solo lo que se quiere conseguir y él se encarga del resto).


El servicio es accesible desde el host en localhost:8080, gracias a la redirección del puerto 8080 del host al puerto 80 de la máquina virtual, donde Apache escucha las solicitudes HTTP entrantes.

