#!/bin/bash

# Lists directorys
#dir="$(dirname "$0")"
#APPS="$PWD/data/apps.list"

function apps() {

    # Instalando aplicativos
    pkginstall $APPS

    # Baixando e instalando pacotes .deb
    pkgfileinstall $DWLDS

    success "Apps instalado!"
}
