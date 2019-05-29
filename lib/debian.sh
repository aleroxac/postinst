#!/bin/bash

function sysupdate(){
    printf "Atualizando sua lista de pacotes...\n"
    sudo apt-get update
}

function sysupgrade(){
    printf "Atualizando seu sistema...\n"
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade
}

function pkginstall(){
    printf "Instalando pacotes...\n"
    sudo apt-get install $(cat $1)
}

function installdepends() { sudo apt-get install -fy ; }

function pkgfileinstall(){
    printf "Baixando e instalando pacotes .deb...\n"
    wget -c -P ~/Downloads -i $1
    sudo dpkg -i ~/Downloads/*.deb
    installdepends
}

function sysautoremove() { sudo apt-get autoremove -y ; }

function pkgremove(){
    dpkg --get-selections $(cat $1) > /tmp/remapps.tmp 2> /dev/null

    if [ -s /tmp/remapps.tmp ]; then
        REMAPPS=$(cat /tmp/remapps.tmp | awk '{print $1}')
        printf '\nRemovendo aplicações desnecessárias...\n'
        cat /tmp/remapps.tmp|awk '{print $1}'|nl;echo

        sudo apt-get remove --purge $REMAPPS
        if [ $(dpkg --get-selections deborphan >/dev/null) ]; then
            sudo apt-get remove --purge -y $(deborphan)
        fi
        sysautoremove
        sysclean
    else
        success "Remover aplicações desnecessárias"
    fi
    if [ -e /tmp/remapps.tmp ]; then rm /tmp/remapps.tmp;fi
}

function sysclean(){
    printf 'Limpando cache do gerenciador de pacotes...\n'
    sudo apt-get autoclean -y
    sudo apt-get clean
}
