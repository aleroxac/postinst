#!/usr/bin/env bash

function apps() {
    pkginstall $APPS
    pkgfileinstall $DWLDS
    success "Apps instalado!"
}
