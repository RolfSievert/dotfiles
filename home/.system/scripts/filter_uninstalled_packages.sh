#!/usr/bin/env bash
#
# missing‑pacman‑pkgs.sh
#
# Usage:
#   ./missing-pacman-pkgs.sh pkg1 pkg2 pkg3 …
#
# The script prints, one per line, the packages that are *not* installed.
# If every argument is already installed it prints nothing and exits 0.
# If no arguments are supplied it shows a short usage message and exits 1.

set -euo pipefail   # safer defaults

# ---------- helper ----------
usage() {
    cat <<EOF
Usage: ${0##*/} PKG [PKG ...]
Print the names of the packages that are *not* installed on the system
(using Pacman).

Example:
  $ ./${0##*/} vim git neovim
  neovim          ← printed because it isn’t installed
EOF
    exit 1
}

# ---------- argument check ----------
[[ $# -gt 0 ]] || usage   # show usage if nothing was passed

# ---------- core logic ----------
for pkg in "$@"; do
    # Pacman returns 0 if the package is installed, non‑zero otherwise.
    if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
        printf '%s\n' "$pkg"
    fi
done
