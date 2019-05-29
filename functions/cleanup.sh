#!/bin/bash

#dir="$(dirname "$0")"
#PURGED="$dir/data/purge.list"

function cleanup() {
    # Removendo pacotes desnecessários
    pkgremove $PURGED

    success "Pacotes desnecessários removidos!"
}
