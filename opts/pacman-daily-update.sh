# this is not the best practice, but it's more convenient for non-tech person. 
# I will just tell them they need to update Arch once in a while or it  will 
# break

serviceaddr=/lib/systemd/system/pacman-daily-update

sudo bash -c "echo '[Unit]
Description=Run pacman-daily-update.service daily

[Timer]
OnCalendar=daily
Persistent=true
AccuracySec=1h

[Install]
WantedBy=timers.target' > $serviceaddr.timer"

sudo bash -c "echo '[Unit]
Description=Update Pacman repository database daily
After=network-online.target nss-lookup.target graphical-session.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/bin/pacman -Sy
Nice=19
StandardOutput=null
StandardError=journal
Restart=on-failure
RestartSec=10s
StartLimitIntervalSec=3h
StartLimitBurst=10

[Install]
WantedBy=multi-user.target
' > $serviceaddr.service"

sudo systemctl enable --now $serviceaddr.timer
