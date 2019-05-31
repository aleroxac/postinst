#!/bin/bash

# Import settings
dir="$(dirname "$0")"
PIPLIST="$PWD/data/pip.list"
PYENV="$PWD/data/pyenv.list"

function setpyenv(){
if ! [ -e ~/.pyenv/versions/3.5.0 ]; then
    printf "\nInstalar utilitários para o pyenv...\n"
    pkginstall $PYENV 2> /dev/null

    printf "\nBaixando e instalando o pyenv...\n"
    curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

    if ! cat ~/.bashrc | grep "pyenv virtualenv-init" > /dev/null; then
        printf "\n\nexport PATH='$HOME/.pyenv/bin:$PATH'" >> $HOME/.bashrc
        printf "eval '$(pyenv init -)'" >> $HOME/.bashrc
        printf "eval '$(pyenv virtualenv-init -)'" >> $HOME/.bashrc
        source ~/.bashrc
    fi

    printf '\nInstalando e definindo o python 3.5.0 como padrão no pyenv...'
    pyenv install 3.5.0
    pyenv global 3.5.0

    printf "\nInstalando os items da piplist...\n"
    pip install $(cat $PIPLIST)
    else
    success "Pyenv instalado!"
    fi
}

