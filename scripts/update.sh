if [ "$EUID" -ne 0 ]; then
    sudo "$0" "$u" "$@"
    exit $?
fi

pacman -Syu 
pacman -Scc 
pacman -Rn $(pacman -Qqdt)
