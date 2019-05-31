#!/usr/bin/env bash

for i in $(ls phanteon); do
    . $PWD/phanteon/$i
done

# Executando scripts de customização do diretório phanteon
function phanteon() {
	bootup
    customize
	speedup
}
