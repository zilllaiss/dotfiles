#!/usr/bin/env bash

DISTRO_ID=$(grep '^ID' /etc/os-release | cut -d '=' -f2)

set -euo pipefail

input=('fcitx5' 'fcitx5-mozc' 'fcitx5-configtool')
graphics=('krita' 'kdenlive' 'inkscape' 'gimp')
gaming=('steam' 'wine' 'winetricks' 'wine-mono' 'wine-gecko' 'kdialog')
util=('optiimage' 'gsmartcontrol' 'gnome-boxes' 'qbittorrent')

# available in chaotic-aur:
# localsend planify

arch_install () {
    sudo pacman -S --noconfirm --needed ${input[*]} ${util[*]} ${graphics[*]} ${gaming[*]} \
	nextcloud-client anki 

    paru -S google-earth-pro
}

flatpak_install () {
    flatpak install -y com.rafaelmardojai.Blanket io.github.alainm23.planify \
	io.github.diegoivanme.flowtime md.obsidian.Obsidian me.hyliu.fluentreader \
	com.obsproject.Studio io.github.ungoogled_software.ungoogled_chromium

    # flatpak anki has some problems
}

case "$DISTRO_ID" in
'cachyos arch')
	arch_install
    flatpak_install
    ;;
arch)
	arch_install
    flatpak_install
    ;;
esac

