# Changelog

## Unreleased

### 2026-11-28 (sqlite3 3.8.0, and the wasm is fetched, not tracked)
- The hub pin 5f8bc07ae fetches the 3.8.0 build of `web/sqlite3.wasm`, and its web-artefacts check holds the
  lock to the same release, so the deploy failed on the tracked 3.7.1 copy. `pubspec.yaml`'s floor is `^3.8.0`
  and the lock moves that one entry, as OmniAccelerANT did. The wasm is untracked now (owner decision):
  `ci-container-steps.sh` fetches it before the Dart checks and both web builds, as do `build-in-container.sh`
  and `run-nginx-integration-test.sh`. Its `large-files.allow` row goes with it. Run
  `bash scripts/setup-sqlite3-wasm.sh` once before `flutter run -d chrome`.

### 2026-11-27 (the Linux runner loads libgcc_s before Flutter's unwinder)
- `linux/CMakeLists.txt` calls the hub's `kataglyphis_flutter_unwinder_first` before it links `flutter`. Flutter
  3.50's `libflutter_linux_gtk.so` exports LLVM libunwind's `_Unwind_*`, so the first C++ exception in the Linux app
  would abort it; `libgcc_s.so.1` now leads the runner's NEEDED list (hub failure-modes.md, "A Flutter 3.50 Linux
  app aborts at its first C++ exception"). The hub pin moves to 5f8bc07ae, which carries the module. No CI lane
  builds the Linux desktop app, so the hub's `check-flutter-unwinder-order.sh` is not wired in yet.

### 2026-11-24 (AGENTS.md matches the tree)
- `AGENTS.md` says `develop` runs the live-site check on both dev domains, as `web.yml` has done since 2026-11-20; it
  said develop had no check. § 5 says the `flutter` and `dart` commands need Flutter on PATH and shows how to run a
  phase in the family image instead, and the MANDATORY box names the two E2E tests the block already required before a
  commit. No code changed.

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
