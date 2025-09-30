#!/usr/bin/env bash
set -euo pipefail

# Obtiene el directorio donde está el script actual
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ejecuta otro script que está en el mismo directorio
"$SCRIPT_DIR/GameDev/PSPinstall.sh"
