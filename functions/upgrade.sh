#!/usr/bin/env bash

function upgrade() {
    # Atualizando lista de pacotes e sistema
    sysupdate
    sysupgrade
    success "Sistema atualizado!"
}
