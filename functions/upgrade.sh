#!/bin/bash

dir="$(dirname "$0")"

function upgrade() {
    # Atualizando lista de pacotes e sistema
    sysupdate
    sysupgrade

    success "Sistema atualizado!"
}
