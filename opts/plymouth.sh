if [ "$EUID" -ne 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

set -euo pipefail

pacman -S --noconfirm --needed plymouth plymouth-kcm

if [ ! -f /etc/mkinitcpio.conf]; then
    echo "no mkinitcpio.conf doesn't exist"
    exit 1
fi

sed -i -e 's/udev autodetect/udev plymouth autodetect/' /etc/mkinitcpio.conf

mkinitcpio -P 

sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/s|"$|splash rd.udev.log_priority=3 vt.global_cursor_default=0 plymouth.boot-log=/dev/null systemd.show_status=auto"|' /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
