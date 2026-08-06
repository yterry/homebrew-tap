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
  version "1.1.0"
  sha256 "a562d68c9c5d9445ddf3d3e994ca0f007caaa41992fe031fbc2aef6b9da2dfe5"

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
