source /etc/os-release

case "$ID_LIKE" in 
arch)
    sudo pacman -Sy --no-confirm fish fisher
    fisher install pure-fish/pure
    fish_config theme choose Nord
    ;;
esac
