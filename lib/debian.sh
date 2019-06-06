#!/usr/bin/env bash

function sysupdate(){ apt update ;}

function pkginstall(){ apt install $(cat $1) ;}

function installdepends() {  apt install -fy ;}

function sysclean(){ apt autoclean -y && apt clean ;}

function sysautoremove() { apt autoremove -y ;}

function sysupgrade(){ 
    apt upgrade -y && apt dist-upgrade -y
    success "Sistema atualizado!"
}

function pkgfileinstall(){
    wget -c -P ~/Downloads -i $1
    dpkg -i ~/Downloads/*.deb
    installdepends
}

function pkgremove(){
    PKGS_TO_REMOVE='/tmp/pkgs_to_remove'
    dpkg --get-selections $(cat ${PURGE}) 2> /dev/null | awk '{print $1}' > ${PKGS_TO_REMOVE}

    if [ $( wc -l ${PKGS_TO_REMOVE} | awk '{print $1}') -gt 1 ] ; then
        apt remove --purge -y $(cat ${PKGS_TO_REMOVE})
        rm -f ${PKGS_TO_REMOVE}

        sysautoremove && sysclean
        apt remove --purge -y $(deborphan)

        success "Pacotes desnecessários removidos!"
    else
        warning "Não haviam pacotes para serem removidos."
    fi
}
