#!/usr/bin/env bash
# Copy shared skills into every plugin.
#
# Each platform installs a plugin by copying its folder, so a plugin can't
# reference files outside it. Shared skills live in shared/skills/ and this
# script copies them into plugins/*/skills/. Edit the shared copy, never the
# copies inside plugins/.
#
# Usage:
#   scripts/sync-shared.sh          copy shared skills into each plugin
#   scripts/sync-shared.sh --check  exit 1 if any plugin copy is out of date
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
check=false
[[ "${1:-}" == "--check" ]] && check=true

stale=0
for plugin in "$root"/plugins/*/; do
  for skill in "$root"/shared/skills/*/; do
    name="$(basename "$skill")"
    dest="${plugin}skills/$name"
    if $check; then
      if ! diff -r "$skill" "$dest" >/dev/null 2>&1; then
        echo "out of date: ${dest#"$root"/}"
        stale=1
      fi
    else
      mkdir -p "$dest"
      rsync -a --delete "$skill" "$dest/"
      echo "synced: ${dest#"$root"/}"
    fi
  done
done

if $check && [[ $stale -ne 0 ]]; then
  echo "Run scripts/sync-shared.sh and commit the result." >&2
  exit 1
fi
