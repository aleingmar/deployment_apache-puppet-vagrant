## Things to have in mind:

The project includes two versions, each in its own folder: /easy_mode and /hard_mode.

- The first folder (/easy_mode) contains the deployment project with a simplified structure. This version does not follow the architecture and code organisation of complex deployment projects, and the Apache configuration is more basic.

- The second folder (/hard_mode) uses a more Puppet-friendly code pattern, for example using modules and other Puppet-typical elements. In addition, the Apache configuration is more advanced and detailed.

Both versions manage to deploy correctly

----

El proyecto incluye dos versiones, cada una en su propia carpeta: /easy_mode y /hard_mode.

- En la primera carpeta (/easy_mode) se encuentra el proyecto de despliegue con una estructura simplificada. Esta versión no sigue una arquitectura ni una organización de código propias de proyectos de despliegue complejos, y la configuración de Apache es más básica.

- En la segunda carpeta (/hard_mode) se utiliza un patrón de código más adecuado para Puppet, empleando, por ejemplo, módulos y otros elementos típicos de esta tecnología. Además, la configuración de Apache es más avanzada y detallada.

Ambas versiones consiguen realizar el despliegue correctamente

## Automated Web Server Deployment with Vagrant and Puppet.

This project was developed for the Deployment Automation course, as part of the official university master's degree in Development and Operations (DevOps).

The aim of the project is to deploy and configure in an automated way a web environment on a virtual machine hosting an Apache server, which serves a basic web page. The virtual machine is created using IaC (Infrastructure as Code) with Vagrant, and Puppet is used for its provisioning, which manages the installation of Apache and the automatic loading of a simple HTML file, thus creating a functional web service.

In short, simply running a ‘vagrant up’ starts the whole deployment and provisioning process and automatically (without doing anything else) a virtual machine is raised in which puppet is installed, an Apache web server is configured and installed to activate and listen to port 80 (http) of the VM and to return a simple web page that is inserted inside it.

The GiHub repository consists of a directory containing a ‘Vagrantfile’ file and a ‘manifests’ folder containing the ‘apache.pp’ file.

- The Vagrantfile defines the virtual machine infrastructure that needs to be deployed to support the web service. This is taken care of by Vagrant and underneath it, it uses VirtualBox as virtualisation provider.

 - In the Vagrantfile, before telling Vagrant to provision the infrastructure using Puppet, a script is run to install Puppet inside the virtual machines. Puppet in this case works in stand-alone mode (without following the client-server model).

- The file ‘apache.pp’ defines the desired configuration for this infrastructure and serves as a declarative guide for Puppet to develop its work. Since Puppet uses a declarative language, you don't tell it how you want things to be done, only what you want to achieve, and Puppet does the rest.


The service is accessible from the host on localhost:8080 by redirecting port 8080 on the host to port 80 on the virtual machine, where Apache listens for incoming HTTP requests.

----

Este proyecto fue desarrollado para la asignatura de Automatización de Despliegues, como parte del máster universitario oficial en Desarrollo y Operaciones (DevOps).

El objetivo del proyecto es desplegar y configurar de manera automatizada un entorno web en una máquina virtual que hospeda un servidor Apache, el cual sirve una página web básica. La máquina virtual se crea mediante IaC (Infrastructure as Code) con Vagrant, y para su aprovisionamiento se utiliza Puppet, que gestiona la instalación de Apache y la carga automática de un archivo HTML simple, creando así un servicio web funcional.

En definitiva, simplemente ejecutando un 'vagrant up' comienza todo el proceso de despliegue y aprovisionamiento y de forma automática (sin hacer nada más) se levanta una máquina virtual en la cual se instala puppet, se configura e instala un servidor web Apache para que se active y escuche el puerto 80 (http) de la Mv y para que devuelva una página web simple que se introduce en su interior.


El repositorio de GiHub se compone de un directorio donde se encuentra un fichero "Vagrantfile" y una carpeta "manifests" en cuyo interior se encuentra el fichero "apache.pp".

- En el Vagrantfile se define la infraestructura de máquinas virtuales que es necesaria desplegar para sustentar el servicio web. De esto se encarga Vagrant y por debajo, usa como proveedor de virtualización VirtualBox.

 - En el Vagrantfile antes de indicarle a Vagrant que debe hacer el aprovisionamiento de la infraestructura usando Puppet, se ejecuta un script para instalar Puppet dentro de las máquinas virtuales. Puppet en este caso trabaja en modo stand-alone (sin seguir modelo cliiente-servidor).

- En el fichero "apache.pp" se define la configuración deseada para esta infraestructur y le sirve a Puppet de guía declarativa para desarrollar su trabajo. Como Puppet usa un lenguaje declarativo no se le indica como se quiere que se hagan las cosas, sino solo lo que se quiere conseguir y Puppet se encarga del resto.


El servicio es accesible desde el host en localhost:8080 gracias a la redirección del puerto 8080 del host al puerto 80 de la máquina virtual, donde Apache escucha las solicitudes HTTP entrantes.