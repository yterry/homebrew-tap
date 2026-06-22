#!/usr/bin/env bash
# Bump the razer-seiren cask to a published release.
#
# Fetches the released Seiren-<version>.zip.sha256 from the GitHub release and
# rewrites `version` + `sha256` in Casks/razer-seiren.rb. Run AFTER the upstream
# release is published (the .sha256 asset must exist).
#
#   scripts/bump-cask.sh 1.0.0
#
set -euo pipefail

VERSION="${1:?usage: bump-cask.sh <version>   e.g. 1.0.0}"
HERE="$(cd "$(dirname "$0")" && pwd)"
CASK="${HERE}/../Casks/razer-seiren.rb"
URL="https://github.com/yterry/razer-seiren-macos/releases/download/v${VERSION}/Seiren-${VERSION}.zip.sha256"

echo "==> fetching ${URL}"
SHA="$(curl -fsSL "${URL}" | awk 'NR==1{print $1}')"
# Guard against a non-empty-but-garbage fetch (HTML error page, redirect, 404
# served as HTML): only a real 64-char lowercase hex digest may reach the cask,
# or a future `brew install` fails for every user with a sha256 mismatch.
[[ "${SHA}" =~ ^[0-9a-f]{64}$ ]] || {
  echo "fetched value for v${VERSION} is not a sha256 (got: '${SHA}')" >&2; exit 1
}
echo "==> v${VERSION}  sha256=${SHA}"

# Portable in-place edit (BSD + GNU sed) via a temp file.
tmp="$(mktemp)"
sed -E -e "s/^  version \".*\"/  version \"${VERSION}\"/" \
       -e "s/^  sha256 \".*\"/  sha256 \"${SHA}\"/" "${CASK}" > "${tmp}"
mv "${tmp}" "${CASK}"

echo "==> updated ${CASK}:"
grep -E '^  (version|sha256) ' "${CASK}"
