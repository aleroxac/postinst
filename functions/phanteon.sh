#!/bin/bash

# Import settings
dir="$(dirname "$0")"
source $PWD/etc/postinstrc

for i in $(ls $PHANTEON); do
    . $PWD/functions/phanteon/$i
done

# Executando scripts de customização do diretório phanteon
function phanteon() {
	bootup
    customize
	speedup
}
