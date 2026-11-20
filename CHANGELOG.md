# Changelog

## Unreleased

### 2026-11-20 (single-threaded skwasm)
- `web/flutter_bootstrap.js` sets `forceSingleThreadedSkwasm: true`: the site is cross-origin isolated, so skwasm
  rendered with web workers, and one of them threw `Cannot read properties of undefined (reading 'postMessage')`
  (`canvaskit/skwasm.js:33`) on about half of the cold loads in the live check (hub CON150). Flutter's own workaround
  until the family's Flutter reaches 3.50.1, which fixes multi-threaded skwasm (flutter/flutter#196127).

### 2026-11-20 (the dev domains get the live-site check)
- `web.yml` runs `check-live-site.py` after each develop upload too: the WASM domain before the CanvasKit build replaces
  `build/web`, then the dev domain. Their URLs come from the `DEV_WASM_SITE_URL` and `DEV_SITE_URL` secrets (hub CON148).

- Ship the app's own MIT licence in every build and list it on the licences page; pin
  ANThology, whose shell now lists the Roboto font's Apache-2.0 text.

- Reuse ANTfrastructure's Flutter gate for Android launcher manifest and resource validation.

- Search local and direct-submodule Bash/PowerShell helpers before adding behavior here;
  extend their shared owner for functionality used by other consumers.
- Pin ANTfrastructure's shared Bash/PowerShell reuse scanner so CI reports
  consumer-to-hub overlap candidates.
- Pin ANTfrastructure to the Renovate driver that updates both direct submodules to their
  remote default branches and initializes missing checkouts on apply, including WSL over
  Windows Git checkouts.
- Verify the Renovate wrapper and shared config in CI without applying updates.
- Add shared CI size, complexity, duplication and Ruff/ty reports, with a manual Python
  refactor preview. Generated local reports stay in ignored `logs/`.
- Keep the selected route and page state when language, theme or layout changes.
- Use ANThology's native open/save dialogs and shared file-action error feedback.
- Reuse ANThology's dev-only layout and navigation contracts, including actual control taps.
- Remove the unused `provider` and `mockito` dependencies.
