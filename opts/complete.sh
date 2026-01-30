#!/usr/bin/env bash

source /etc/os-release 
DISTRO_ID=$ID

set -euo pipefail

# TODO: probably these should be groupped per distro instead
input=('fcitx5' 'fcitx5-mozc' 'fcitx5-configtool')
graphics=('krita' 'kdenlive' 'inkscape' 'gimp')
util=('optiimage' 'gsmartcontrol' 'gnome-boxes' 'qbittorrent' 'librewolf')
# 'wine' 'winetricks' 'wine-mono' 'winezabbix-gecko' 'kdialog'

# available in chaotic-aur:
# localsend planify

arch_install () {
    sudo pacman -S --noconfirm --needed ${input[*]} ${util[*]} ${graphics[*]} \
	nextcloud-client anki tenacity digikam signal-desktop

    paru -S --needed --noconfirm --skipreview google-earth-pro 
}

flatpak_install () {
    flatpak install -y com.rafaelmardojai.Blanket me.hyliu.fluentreader \
	io.github.ungoogled_software.ungoogled_chromium com.valvesoftware.Steam \
    com.discordapp.Discord fr.handbrake.ghb io.github._0xzer0x.qurancompanion \
    io.github.peazip.PeaZip com.heroicgameslauncher.hgl com.github.ransome1.sleek \
    page.codeberg.libre_menu_editor.LibreMenuEditor
}

abd () {
    bash <(curl -fsSL https://raw.githubusercontent.com/amir1376/ab-download-manager/master/scripts/install.sh)
}

abd

case "$DISTRO_ID" in
'cachyos')
	arch_install
    flatpak_install
    ;;
arch)
	arch_install
    flatpak_install
    ;;
debian)
# org.kde.digikam
# com.github.jeromerobert.pdfarranger
# com.github.mtkennerly.ludusavi
# com.github.qarmin.szyszka
# com.obsproject.Studio
# com.rafaelmardojai.Blanket
# io.github.dvlv.boxbuddyrs
# io.github.ungoogled_software.ungoogled_chromium
# io.gitlab.librewolf-community
# me.hyliu.fluentreader
# net.ankiweb.Anki
# org.freefilesync.FreeFileSync
# org.gimp.GIMP
# org.inkscape.Inkscape
# org.kde.gwenview
# org.kde.haruna
# org.kde.kdenlive
# org.kde.krita
# org.kde.okular
# org.kde.optiimage
# org.libreoffice.LibreOffice
# org.localsend.localsend_app
# org.onlyoffice.desktopeditors
# org.qbittorrent.qBittorrent
# org.tenacityaudio.Tenacity
esac

