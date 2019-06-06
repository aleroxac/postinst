#!/usr/bin/env bash

check_resources

function cleanup() {
    pkgremove ../data/purge.list
}
