set -euo pipefail

source /etc/os-release 
DISTRO_ID=$ID

case "$DISTRO_ID" in 
arch)
    pacman -S gimagereader-gtk tesseract-data-eng hunspell-en_us
    ;;
esac
