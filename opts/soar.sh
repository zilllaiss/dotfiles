set -euo pipefail

curl -fsSL "https://raw.githubusercontent.com/pkgforge/soar/main/install.sh" | sh

soar defconfig --external
soar sync

read -p ' to PATH?'

echo "
Soar successfully installed!

Add '~/.local/share/soar/bin' to PATH if you haven't already.
You can add additional repositories listed in https://docs.pkgforge.dev/repositories/external.
"

