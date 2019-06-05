#!/usr/bin/env bash

source ../etc/skel
check_resources

function cleanup() {
    # Removendo pacotes desnecessários
    # pkgremove ../data/purge.list

    success "Pacotes desnecessários removidos!"
}
