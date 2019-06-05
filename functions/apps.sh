#!/usr/bin/env bash

function apps() {

    # Instalando aplicativos
    pkginstall $APPS

    # Baixando e instalando pacotes .deb
    pkgfileinstall $DWLDS

    success "Apps instalado!"
}
