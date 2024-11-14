#!/bin/bash

# SI AL EJECUTAR EL SCRIPT, DEVUELVE EL ERROR
# /bin/bash^M: bad interpreter: No such file or directory
# at the bottom of VSCode there should be a little toolbar. If you click on CRLF and instead change it to LF

sudo mkdir -p /vagrant

sudo /opt/puppetlabs/bin/puppet apply --modulepath=./modules ./manifests/default.pp