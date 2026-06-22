# Homebrew cask for Seiren (macOS) — https://github.com/yterry/razer-seiren-macos
#
#   brew tap yterry/tap
#   brew install --cask razer-seiren
#
# The app is unsigned (no paid Apple Developer ID yet); a personal tap has no
# notarization requirement, and the postflight xattr below clears the Gatekeeper
# quarantine flag so the build runs with no manual bypass. REMOVE the postflight
# block once the app is notarized.
#
# On each upstream release, run `scripts/bump-cask.sh <version>` (it fetches the
# published .sha256 and rewrites `version` + `sha256`), then commit and push.
cask "razer-seiren" do
  version "1.0.0"
  sha256 "ee00f1c35ce502971f51697b93744d64cd31ebcd95c26bd16359b82ad012efa0"

  url "https://github.com/yterry/razer-seiren-macos/releases/download/v#{version}/Seiren-#{version}.zip"
  name "Seiren"
  desc "Voice toolkit for Razer Seiren mics — EQ, noise suppression, and monitoring"
  homepage "https://github.com/yterry/razer-seiren-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :ventura # minimum; matches LSMinimumSystemVersion 13.0

  app "Seiren.app"

  # Unsigned build: clear the quarantine xattr so Gatekeeper lets it run.
  # REMOVE this block once the app is notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Seiren.app"]
  end

  uninstall quit: "com.yterry.seiren-mac"

  zap trash: [
    "~/Library/Application Support/Seiren",
    "~/Library/Preferences/com.yterry.seiren-mac.plist",
  ]
end
