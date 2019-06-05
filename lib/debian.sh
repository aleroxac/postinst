#!/usr/bin/env bash

function sysupdate(){
    printf "Atualizando sua lista de pacotes...\n"
    apt update
}

function sysupgrade(){
    printf "Atualizando seu sistema...\n"
    apt upgrade -y
    apt dist-upgrade -y
}

function pkginstall(){
    printf "Instalando pacotes...\n"
    apt install $(cat $1)
}

function installdepends() {  apt install -fy ; }

function pkgfileinstall(){
    printf "Baixando e instalando pacotes .deb...\n"
    wget -c -P ~/Downloads -i $1
    dpkg -i ~/Downloads/*.deb
    installdepends
}

function sysautoremove() { apt autoremove -y ; }

function pkgremove(){
    dpkg --get-selections $(cat $1) > /tmp/remapps.tmp 2> /dev/null

    if [ -s /tmp/remapps.tmp ]; then
        REMAPPS=$(cat /tmp/remapps.tmp | awk '{print $1}')
        printf '\nRemovendo aplicações desnecessárias...\n'
        cat /tmp/remapps.tmp|awk '{print $1}'|nl;echo

        apt remove --purge $REMAPPS
        if [ $(dpkg --get-selections deborphan >/dev/null) ]; then
            apt remove --purge -y $(deborphan)
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
    apt autoclean -y
    apt clean
}
