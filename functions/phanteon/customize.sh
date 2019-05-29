#!/bin/bash

DOTF="$PWD/data/dotfiles.list"

function customize() {

    # Configurando ignore-case no bash
	if ! $(cat /etc/inputrc | grep "set completion-ignore-case on"); then
		echo set completion-ignore-case on | sudo tee -a /etc/inputrc > /dev/null
        success "Ignore-case no bash configurado!"
	fi

	# Configurando seus diretórios xdg
	if ! $(cat ~/.config/user-dirs.dirs | grep "Meus xdg-dirs pessoais" > /dev/null); then
        xdg-user-dirs-update

        mv $XDG_DESKTOP_DIR $My_XDG_DESKTOP_DIR
        mv $XDG_DOCUMENTS_DIR $My_XDG_DOCUMENTS_DIR
        mv $XDG_DOWNLOAD_DIR $My_XDG_DOWNLOAD_DIR
        mv $XDG_TEMPLATES_DIR $My_XDG_TEMPLATES_DIR
        mv $XDG_MUSIC_DIR $My_XDG_MUSIC_DIR
        mv $XDG_VIDEOS_DIR $My_XDG_VIDEOS_DIR
        mv $XDG_PICTURES_DIR $My_XDG_PICTURES_DIR
        mv $XDG_PUBLICSHARE_DIR $My_XDG_PUBLICSHARE_DIR

        xdg-user-dirs-update --set DESKTOP $My_XDG_DESKTOP_DIR
        xdg-user-dirs-update --set DOWNLOAD $My_XDG_DOWNLOAD_DIR
        xdg-user-dirs-update --set TEMPLATES $My_XDG_TEMPLATES_DIR
        xdg-user-dirs-update --set PUBLICSHARE $My_XDG_PUBLICSHARE_DIR
        xdg-user-dirs-update --set DOCUMENTS $My_XDG_DOCUMENTS_DIR
        xdg-user-dirs-update --set MUSIC $My_XDG_MUSIC_DIR
        xdg-user-dirs-update --set PICTURES $My_XDG_PICTURES_DIR
        xdg-user-dirs-update --set VIDEOS $My_XDG_VIDEOS_DIR
	else
		success "xdg-user-dirs configurados!"
	fi
}
