#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

chmod +x "$script_dir/adnre_scripts/lamp-setup.sh"
chmod +x "$script_dir/minecraft/start.sh"
chmod +x "$script_dir/minecraft/serveropset.sh"
chmod +x "$script_dir/minecraft/online.sh