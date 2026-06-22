# yterry/homebrew-tap

Homebrew tap for [**Seiren for macOS**](https://github.com/yterry/razer-seiren-macos) —
a macOS menu-bar voice toolkit for Razer Seiren mics: EQ, noise suppression, and
headphone monitoring, routed into OBS / Zoom / Discord.

## Install

```sh
brew tap yterry/tap
brew install --cask razer-seiren
```

Upgrade later with `brew upgrade --cask razer-seiren`.

> If Homebrew refuses the cask as an "untrusted tap" (newer Homebrew can gate
> third-party taps), run `brew trust yterry/tap` once and retry.

The app is **unsigned** (no paid Apple Developer ID yet), so the cask clears the
Gatekeeper quarantine flag for you — it launches with **no manual bypass**. That
gets you headphone monitoring right away; to unlock the EQ + noise suppression and
process what other apps record, open **🎙 → Voice ▸ Install Seiren FX…** once (it
asks for your password — a one-time admin prompt to install the audio device).

## Releasing (maintainer)

After a new release of the app is published:

```sh
scripts/bump-cask.sh <version>          # fetches the release .sha256, rewrites the cask
git commit -am "razer-seiren <version>"
git push
```

The app's release CI runs this automatically when a `HOMEBREW_TAP_TOKEN` secret
(a PAT with write access to this repo) is configured.

## License

The cask metadata here is MIT-licensed, matching
[Seiren for macOS](https://github.com/yterry/razer-seiren-macos).
