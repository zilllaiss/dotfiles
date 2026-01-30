set -euo pipefail

BIN_DIR=~/.local/bin
mkdir -p "$BIN_DIR"

curl -fsSL "https://raw.githubusercontent.com/pkgforge/soar/main/install.sh" | sh

soar defconfig --external
soar sync

echo "
Soar successfully installed!

Add '~/.local/share/soar/bin' to PATH if you haven't already.
You can add additional repositories listed in https://docs.pkgforge.dev/repositories/external.
"

