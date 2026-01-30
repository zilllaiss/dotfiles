source /etc/os-release

case "$ID" in 
arch)
    sudo pacman -Sy --noconfirm --needed fish fisher
    fish -c "fisher install pure-fish/pure; and fish_config theme choose Nord"
    ;;
esac
