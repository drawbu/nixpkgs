#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash curl jq nodejs nix-update

set -euo pipefail

packageDir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

version=$(curl -fsSL "https://api.github.com/repos/unjs/upm/releases/latest" | jq -r '.tag_name | ltrimstr("v")')

if [[ "${UPDATE_NIX_OLD_VERSION:-}" == "$version" ]]; then
  echo "upm is up to date: $version"
  exit 0
fi

workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

curl -fsSL "https://raw.githubusercontent.com/unjs/upm/v$version/package.json" |
  jq 'del(.workspaces)' >"$workdir/package.json"
(cd "$workdir" && npm install --package-lock-only --ignore-scripts)
cp "$workdir/package-lock.json" "$packageDir/package-lock.json"

nix-update "${UPDATE_NIX_ATTR_PATH:-upm}" --version "$version"
