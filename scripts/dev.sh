#!/usr/bin/env bash
# Start Claude Code with the Aced plugin from this checkout.
#
#   scripts/dev.sh                  MCP server at http://localhost:3000/api/mcp (exponent `npm run dev`)
#   scripts/dev.sh --prod           production MCP server, for testing skill changes only
#   ACED_MCP_URL=https://<tunnel>/api/mcp scripts/dev.sh
#
# Any other arguments are passed to `claude`. Skills are symlinked from plugin/skills, so after
# editing a SKILL.md just restart the session.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
prod_url="https://www.aced.io/api/mcp"
url="${ACED_MCP_URL:-http://localhost:3000/api/mcp}"

if [[ "${1:-}" == "--prod" ]]; then
  url="$prod_url"
  shift
fi

# A copy of plugin/ whose manifest points at $url. Everything but the manifest is a symlink.
dev="$root/.dev/plugin"
rm -rf "$root/.dev"
mkdir -p "$dev/.claude-plugin"
for entry in "$root"/plugin/* "$root"/plugin/.[!.]*; do
  [[ -e "$entry" && "$(basename "$entry")" != ".claude-plugin" ]] && ln -s "$entry" "$dev/"
done

manifest="$root/plugin/.claude-plugin/plugin.json"
if ! grep -q "$prod_url" "$manifest"; then
  echo "error: expected $prod_url in plugin/.claude-plugin/plugin.json" >&2
  exit 1
fi
sed "s#$prod_url#$url#" "$manifest" > "$dev/.claude-plugin/plugin.json"

echo "Aced MCP server: $url"
exec claude --plugin-dir "$dev" "$@"
