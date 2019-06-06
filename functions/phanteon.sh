#!/usr/bin/env bash

for i in $(ls phanteon); do
    . $PWD/phanteon/$i
done

function phanteon() {
	bootup
    customize
	speedup
}
