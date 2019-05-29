#!/bin/bash

function bootup() {
	if [ -f /etc/rc.local ]; then
		## Setando bluetooth desligado após boot do sistema
		if $(cat /etc/rc.local | grep "rfkill block bluetooth" > /dev/null); then
			sudo sed -i 's/^exit 0$/rfkill block bluetooth\nexit 0/g' /etc/rc.local
		fi

		## Setando brilho da tela padrão após o boot
		BRIGHTNESS='echo 937 > /sys/class/backlight/intel_backlight/brightness\n\nexit 0'
		if $(cat /etc/rc.local | grep "echo 937"); then
    		sudo sed -i 's|^exit 0$|'"${BRIGHTNESS}"'|g' /etc/rc.local
		fi
	else
		echo "rfkill block bluetooth" > /etc/rc.local
		echo "$BRIGHTNESS" >> /etc/rc.local
	fi

	## Mostrando aplicativos de startup ocultos
	if $(cat /etc/xdg/autostart/*.desktop | grep "NoDisplay=true" > /dev/null) > /dev/null; then
		sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop
	fi

	## Alterando o GRUB_TIMEOUT
	if $(cat /etc/default/grub | grep 'GRUB_TIMEOUT="10"' > /dev/null); then
		sudo sed -i 's|GRUB_TIMEOUT="10"|GRUB_TIMEOUT="'"${GRUBTIMEOUT}"'"|g' /etc/default/grub
		GRUB1=1
	else
		GRUB1=0
	fi

	## Configurando parâmentros do Kernel
	GRUBDEF='GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"'
	if $(cat /etc/default/grub | grep $GRUBDEFAULT) || $(cat /etc/default/grub | grep '="quiet"') > /dev/null; then
		sudo sed -i 's|'"${GRUBDEFAULT}"'|GRUB_CMDLINE_LINUX_DEFAULT="'"$GRUBOPT"'"|g' /etc/default/grub
		GRUB2=1
	else
		GRUB2=0
	fi

	## Atualizando grub
	if [ $GRUB1 -eq 1 ] || [ $GRUB2 -eq 1 ]; then
		grub-mkconfig -o /boot/grub/grub.cfg
	fi

	success "Bootup configurado!"
}
