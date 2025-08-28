#!/usr/bin/env bash

source /etc/os-release 
DISTRO_ID=$ID

set -euo pipefail

input=('fcitx5' 'fcitx5-mozc' 'fcitx5-configtool')
graphics=('krita' 'kdenlive' 'inkscape' 'gimp')
# 'wine' 'winetricks' 'wine-mono' 'winezabbix-gecko' 'kdialog'
gaming=('steam')
util=('optiimage' 'gsmartcontrol' 'gnome-boxes' 'qbittorrent')

# available in chaotic-aur:
# localsend planify

arch_install () {
    sudo pacman -S --noconfirm --needed ${input[*]} ${util[*]} ${graphics[*]} ${gaming[*]} \
	nextcloud-client anki ab-download-manager tenacity

    paru -S google-earth-pro
}

flatpak_install () {
    flatpak install -y com.rafaelmardojai.Blanket \
	io.github.diegoivanme.flowtime md.obsidian.Obsidian me.hyliu.fluentreader \
	io.github.ungoogled_software.ungoogled_chromium

    # flatpak anki has some problems
}

case "$DISTRO_ID" in
'cachyos')
	arch_install
    flatpak_install
    ;;
arch)
	arch_install
    flatpak_install
    ;;
esac

