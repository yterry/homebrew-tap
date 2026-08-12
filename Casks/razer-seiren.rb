# Homebrew cask for Seiren (macOS) — https://github.com/yterry/razer-seiren-macos
#
#   brew tap yterry/tap
#   brew install --cask razer-seiren
#
# Releases from v1.1.0 on are signed with a Developer ID and notarized, so
# Gatekeeper opens them with no bypass and no cask workarounds.
#
# On each upstream release, run `scripts/bump-cask.sh <version>` (it fetches the
# published .sha256 and rewrites `version` + `sha256`), then commit and push.
cask "razer-seiren" do
  version "1.2.0"
  sha256 "c60e099edb6bdabba9d06b3a1096f73aae8b660f1ee01e7cfe6ded0d96f6b31e"

  url "https://github.com/yterry/razer-seiren-macos/releases/download/v#{version}/Seiren-#{version}.zip"
  name "Seiren"
  desc "Voice and lighting toolkit for Razer Seiren mics - EQ, noise suppression, monitoring, Chroma"
  homepage "https://github.com/yterry/razer-seiren-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :ventura # minimum; matches LSMinimumSystemVersion 13.0

  app "Seiren.app"

  uninstall quit: "com.yterry.seiren-mac"

  zap trash: [
    "~/Library/Application Support/Seiren",
    "~/Library/Preferences/com.yterry.seiren-mac.plist",
  ]
end
