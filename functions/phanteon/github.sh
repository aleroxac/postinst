#!/bin/bash

function github(){

    # Solicitando entrada de dados do usuário
    read -p "Qual o seu nome de usuário do Github?: " GITUSER
    read -s -p "Qual sua senha do Github?: " GITPWD;echo
    read -p "Qual será o nome de sua chave ssh?: " KEYTITLE;echo

    # Criando chavé ssh pública e privada
    ssh-keygen -t rsa -b 4096 -C augustocs.ti@hotmail.com
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    KEY=$(cat ~/.ssh/id_rsa.pub)

    # Criando json para cadastrar chave ssh no github; usando sua própria API
    echo curl -u '"GITUSER:GITPWD"' --data "'{"'"'title'"'":"'"'KEYTITLE'"'","'"'key'"'":"'"'KEY'"'"}'" https://api.github.com/user/keys > ~/gitkey

    sed -i 's|GITUSER|'"${GITUSER}"'|g' ~/gitkey
    sed -i 's|GITPWD|'"${GITPWD}"'|g' ~/gitkey
    sed -i 's|KEYTITLE|'"${KEYTITLE}"'|g' ~/gitkey
    sed -i 's|KEY|'"${KEY}"'|g' ~/gitkey

    # Teste de conexão ssh
    cat ~/gitkey | sh
    ssh -T git@github.com

    success "Git/github configurado!"
}
