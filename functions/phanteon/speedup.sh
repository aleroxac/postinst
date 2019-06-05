#!/usr/bin/env bash

function speedup() {
    # Habilitando prelinking
    if [ -f /etc/default/prelink ]; then
        if cat /etc/default/prelink | grep "PRELINKING=unknown" > /dev/null; then
            sed -i "s/PRELINKING=unknown/PRELINKING=yes/g" /etc/default/prelink
        fi
    fi

    # Configurando opções do prelink
    if cat /etc/default/prelink | grep "PRELINK_OPTS=-mR" > /dev/null; then
        sed -i "s/PRELINK_OPTS=-mR/PRELINK_OPTS=-amR/g" /etc/default/prelink
    fi

    # Executando prelink
    prelink -amvR

    success "Speed Configurado!"
}
