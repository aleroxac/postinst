#!/bin/bash

function apps() {

    # Instalando aplicativos
    pkginstall $APPS

    # Baixando e instalando pacotes .deb
    pkgfileinstall $DWLDS

    clear && success "Apps instalado!"
}
