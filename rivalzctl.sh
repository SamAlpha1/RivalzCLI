#!/usr/bin/env bash
set -euo pipefail

need_node20() {
  command -v node >/dev/null 2>&1 || return 1
  local major
  major="$(node -p 'process.versions.node.split(".")[0]')"
  [[ "$major" -ge 20 ]]
}

check() {
  echo "RivalzCLI environment check"
  echo "OS: $(uname -srm)"
  if command -v node >/dev/null 2>&1; then
    echo "Node: $(node --version)"
  else
    echo "Node: missing"
  fi
  if command -v npm >/dev/null 2>&1; then
    echo "npm: $(npm --version)"
  else
    echo "npm: missing"
  fi
  if command -v rivalz >/dev/null 2>&1; then
    echo "Rivalz: installed ($(command -v rivalz))"
  else
    echo "Rivalz: not installed"
  fi
}

install_cli() {
  if ! need_node20; then
    echo "Node.js 20+ is required. Install a supported Node.js release first." >&2
    exit 2
  fi
  if ! command -v npm >/dev/null 2>&1; then
    echo "npm is required." >&2
    exit 2
  fi
  sudo npm install -g rivalz-node-cli
  echo "Rivalz CLI installed."
}

update_cli() {
  install_cli
  rivalz update-version || true
}

run_cli() {
  command -v rivalz >/dev/null 2>&1 || { echo "Rivalz CLI is not installed." >&2; exit 2; }
  exec rivalz run
}

case "${1:-check}" in
  check) check ;;
  install) install_cli ;;
  update) update_cli ;;
  run) run_cli ;;
  *) echo "Usage: $0 {check|install|update|run}" >&2; exit 2 ;;
esac
