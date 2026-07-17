#!/bin/sh
# beaver installer — downloads the prebuilt binary for this machine from
# the latest GitHub release into ~/.local/bin (override with BEAVER_BIN_DIR).
#
#   curl -fsSL https://raw.githubusercontent.com/cristianelias/beaver-dist/main/install.sh | sh
set -eu

REPO="cristianelias/beaver-dist"
BIN_DIR="${BEAVER_BIN_DIR:-$HOME/.local/bin}"

case "$(uname -s)" in
    Darwin) os="apple-darwin" ;;
    Linux)  os="unknown-linux-gnu" ;;
    *) echo "beaver: unsupported OS $(uname -s) — prebuilt releases support macOS and Linux: https://github.com/$REPO/releases" >&2; exit 1 ;;
esac
case "$(uname -m)" in
    arm64|aarch64) arch="aarch64" ;;
    x86_64|amd64)  arch="x86_64" ;;
    *) echo "beaver: unsupported architecture $(uname -m)" >&2; exit 1 ;;
esac
target="$arch-$os"

asset="beaver-$target.tar.gz"
base="https://github.com/$REPO/releases/latest/download"
url="$base/$asset"
echo "downloading beaver ($target)..."
tmp="$(mktemp -d)"
staged=""
trap 'rm -rf "$tmp"; [ -z "$staged" ] || rm -f "$staged"' EXIT
curl -fsSL --retry 2 --connect-timeout 10 --max-time 120 "$url" -o "$tmp/beaver.tar.gz"
curl -fsSL --retry 2 --connect-timeout 10 --max-time 20 "$base/SHA256SUMS" -o "$tmp/SHA256SUMS"

expected="$(awk -v asset="$asset" '$2 == asset || $2 == "*" asset { print tolower($1); exit }' "$tmp/SHA256SUMS")"
case "$expected" in
    *[!0-9a-f]*|"") echo "beaver: SHA256SUMS has no valid entry for $asset" >&2; exit 1 ;;
esac
if [ "${#expected}" -ne 64 ]; then
    echo "beaver: SHA256SUMS has an invalid digest for $asset" >&2
    exit 1
fi
if command -v sha256sum >/dev/null 2>&1; then
    actual="$(sha256sum "$tmp/beaver.tar.gz" | awk '{print $1}')"
elif command -v shasum >/dev/null 2>&1; then
    actual="$(shasum -a 256 "$tmp/beaver.tar.gz" | awk '{print $1}')"
else
    echo "beaver: sha256sum or shasum is required to verify the download" >&2
    exit 1
fi
if [ "$actual" != "$expected" ]; then
    echo "beaver: checksum mismatch for $asset — refusing to install" >&2
    exit 1
fi
tar -xzf "$tmp/beaver.tar.gz" -C "$tmp"

mkdir -p "$BIN_DIR"
staged="$(mktemp "$BIN_DIR/.beaver-install.XXXXXX")"
install -m 755 "$tmp/beaver" "$staged"
mv -f "$staged" "$BIN_DIR/beaver"
staged=""
echo "installed $BIN_DIR/beaver ($("$BIN_DIR/beaver" --version))"

case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *) echo "note: $BIN_DIR is not on your PATH — add it to your shell rc." ;;
esac

if ! grep -qs 'beaver init' "$HOME/.zshrc" "$HOME/.bashrc" 2>/dev/null; then
    cat <<'EOF'

next step — enable the cd integration (once):
  printf '\n# beaver — git worktree pool manager\neval "$(beaver init zsh)"\n' >> ~/.zshrc && exec zsh
EOF
fi

cat <<'EOF'

teach the coding agents on this machine to use the pool (idempotent):
  beaver init-agents                  # writes the beaver block into agent memory files
  beaver init-agents --claude-hooks   # + route Claude Code's own worktrees through the pool
EOF
