# jotrockenmitlocken

Personal blog as a responsive cross-platform Flutter/Dart web app by Jonas Heinle (@Kataglyphis). Blog posts are written in Markdown, kept private via WebDAV — only the Flutter/Dart source code is open-source.

## Build, Lint & Test

```bash
# Install dependencies (root + external submodule)
flutter pub get && cd third_party/ANThology && flutter pub get && cd -

# Lint & analyze (zero tolerance for errors)
dart analyze

# Check formatting
dart format --output=none --set-exit-if-changed .

# Run tests
flutter test

# Local web dev (no real blog content without WebDAV secrets)
flutter run -d web-server --profile --web-port 8080 --web-hostname 0.0.0.0

# Run integration smoke tests (Flutter Chrome)
flutter test integration_test/ --platform chrome

# Run integration smoke tests (built web app via HTTP server)
bash scripts/run-nginx-integration-test.sh

# Or manually: build, serve, test
flutter build web --release --wasm --no-tree-shake-icons
cd build/web && python3 -m http.server 8080 &
cd .. && bash scripts/integration-smoke-test.sh http://localhost:8080

# Run E2E browser console error capture (Playwright + flatpak Chromium)
python3 scripts/capture_console_errors.py
```

## E2E Testing

Two complementary E2E test methods — **run both** before committing.

### Method 1: Integration Smoke Test (HTTP-level)

Checks HTTP responses, MIME types, CSP headers, and file availability. No browser required.

```bash
# Build the web app (WASM)
flutter build web --release --wasm --no-tree-shake-icons

# Serve and test
cd build/web && python3 -m http.server 8080 &
cd .. && bash scripts/integration-smoke-test.sh http://localhost:8080
```

**What it checks:**
- `index.html` returns HTTP 200
- `main.dart.wasm` serves with `application/wasm` MIME type
- `main.dart.js` and `flutter_bootstrap.js` exist and are non-empty
- `manifest.json` is valid
- CSP permits CanvasKit CDN (`www.gstatic.com`) and Google Fonts (`fonts.gstatic.com`)
- `script-src` allows gstatic.com
- Loading screen uses `MutationObserver` and has `hideLoading` function

### Method 2: Browser Console Error Capture (Playwright + flatpak Chromium)

Launches a real headless browser to capture console logs, page errors, and runtime exceptions.

#### Prerequisites

**Install Chromium via flatpak** (works on all architectures including ARM64):

```bash
flatpak install flathub org.chromium.Chromium

# Install Firefox via flatpak (optional, for manual testing)
flatpak install flathub org.mozilla.firefox
```

**Install Python dependencies** (first time only):

```bash
python3 -m pip install --break-system-packages playwright
```

#### Running the test

```bash
# 1. Build the web app (WASM)
flutter build web --release --wasm --no-tree-shake-icons

# 2. Run the console error capture script
python3 scripts/capture_console_errors.py
```

**What it does:**
1. Starts an HTTP server serving `build/web` on port 8080
2. Launches headless Chromium via Playwright using the flatpak binary
3. Runs comprehensive test suite:
   - **Navigation & Routing**: Verifies all routes (/, /aboutMe, /data, /documents, /error404) load correctly
   - **Responsive Layouts**: Tests mobile (375px), tablet (768px), desktop (1280px), and Full HD (1920px) viewports
   - **Assets & Rendering**: Checks WASM build config, Flutter glass pane, canvas/renderer, and failed resources
   - **Performance Metrics**: Measures DOM content loaded, page load time, resource count, and WASM load time
   - **UI Interactions**: Tests loading screen fade-out, cookie notice, cookie consent button, navigation, and dark mode
4. Reports errors (❌), warnings (⚠️), and info (ℹ️) messages
5. Saves a screenshot to `/tmp/flutter_web_screenshot.png`
6. Cleans up server and browser on exit

**Expected output:** Only a WebGL GPU stall warning in headless mode — no runtime errors.

#### Troubleshooting

- **`No module named 'playwright'`**: Run `python3 -m pip install --break-system-packages playwright`
- **Chromium not found**: Verify with `flatpak list | grep chromium`
- **Port 8080 in use**: Kill existing process with `kill $(lsof -t -i:8080)`
- **Browser launch fails**: Ensure flatpak Chromium is installed and `--no-sandbox` is passed (required in containers/WSL)

```bash
# Build web release (CanvasKit fallback, for non-WASM browsers)
flutter build web --release --no-tree-shake-icons
```

CRITICAL: Always build with `--wasm`. The CanvasKit build is only a fallback for browsers that don't support WASM.

```bash
# Generate localization code from ARB files
flutter gen-l10n
```

**Verification order:** `dart analyze` → `flutter test` → `dart format --output=none --set-exit-if-changed .`

> **MANDATORY for agents:** After making any code changes, you MUST run all three verification commands in order (analyze → test → format) and ensure they all pass with zero errors. If any command fails, fix the issues and re-run before considering the task complete. The CI pipeline enforces zero tolerance on `dart analyze` and `dart format` — failures block deployment.

**Before committing changes:**
```bash
dart analyze && flutter test && dart format --output=none --set-exit-if-changed . && bash scripts/integration-smoke-test.sh http://localhost:8080 && python3 scripts/capture_console_errors.py
```

Only commit if all commands exit with code 0.

## What ContainerHub owns — links only

This repo has a second submodule besides the shared component library:
`third_party/ContainerHub`. It owns every reusable script, container
recipe and build doc shared across the Kataglyphis repos, and **four scripts here
are thin wrappers over it** — editing the wrapper when the behaviour lives
upstream is the mistake to avoid:

| Wrapper | Delegates to |
| --- | --- |
| `scripts/build-in-container.sh` | ContainerHub's container bootstrap |
| `scripts/integration-smoke-test.sh` | shared Flutter-web smoke test |
| `scripts/run-nginx-integration-test.sh` | shared nginx integration harness |
| `scripts/capture_console_errors.py` | shared Flutter-web console-error test |

**Do not restate upstream procedures here.** Start at
[`third_party/ContainerHub/docs/INDEX.md`](third_party/ContainerHub/docs/INDEX.md)
— it maps topic → owning document, so links survive upstream reorganisation. The
rule that decides where anything belongs: *would this still be true in a
different project?* Yes → ContainerHub owns it, link to it. No → write it out
here.

Two upstream facts worth knowing before you reach a doc:

- ContainerHub's PowerShell modules declare `#requires -Version 7.0` — launch
  with `pwsh`, never `powershell`. (Not used by this repo's CI today, which is
  Linux-only, but true if you add a Windows lane.)
- Workflows resolve ContainerHub's composite actions at `@main`, so an upstream
  change a workflow depends on must be pushed **before** the consumer change.

Clone with `--recurse-submodules` or the wrappers fail with an explicit
"did you run `git submodule update --init`?" message rather than a confusing one.

## Project Structure

```
lib/
  main.dart                     # Entry point: loads JSON settings in parallel, configures GoRouter, MaterialApp.router
  Pages/                        # All UI pages
    jotrockenmitlocken_screen_configurations.dart  # All page config registrations
    LandingPage/                #   Landing page with blog entry cards
    AboutMePage/                #   About Me page with skills, charts, donation
    DataPage/                   #   Data sections: books, films, games, quotes, blog overview, SQLite test
    DocumentsPage/              #   Document download page (CV, thesis PDFs)
    ErrorPage/                  #   404 error page
    Footer/                     #   Footer config
    Home/                       #   Home button config
  Routing/                      # RoutesCreator: wires all page configs to GoRouter routes
  l10n/                         # ARB-based localization (German + English + French, 53 strings, auto-generated)
  *.dart                        # Config models: BlogPageConfig, MyTwoCentsConfig, BlogDependentAppAttributes, settings_loader

third_party/ANThology/ # Git submodule — shared component library
  lib/
    app_attributes.dart         # Core data models (AppAttributes, AppSettings, UserSettings)
    Pages/
      markdown_content_page.dart  # Generic Markdown+appendix page (shared)
      Footer/
        generic_footer_page_config.dart  # Parameterized footer page config (shared)
    Widgets/
      skill_table.dart          #   Reusable JSON-to-Table widget (shared)
    Sqlite/                     #   Platform-conditional SQLite self-test (shared)
    Layout/                     # Responsive layout widgets (OneTwoTransitionPage, SinglePage)
    Media/                      # Markdown rendering, file handling, images, data tables
    Routing/                    # Base classes for ScreenConfigurations, RoutesCreator
    Decoration/                 # Visual decoration helpers, charts
    SocialMedia/                # Social media link handling
```

## Architecture & Conventions

- **State management:** Provider (`package:provider`)
- **Routing:** GoRouter (`package:go_router ^17.1.0`) with declarative named routes
- **Responsive layout:** Switch between single-page and two-column layout based on screen width breakpoints (defined in `third_party/ANThology/lib/constants.dart`)
- **Content:** Blog posts in Markdown, rendered via `markdown_widget` / `flutter_markdown_plus`. Book/film/game reviews via `my_two_cents_config.json`.
- **Localization:** ARB files in `lib/l10n/` (template: `app_en.arb`), output auto-generated to `app_localizations.dart`. Always run `flutter gen-l10n` after editing ARB files.
- **Page pattern:** Each page implements `StatefulBranchInfoProvider` (from shared repo) which provides `getRoutingName()` and a GoRouter-compatible page builder. Config classes hold route metadata, icon, label, and page builder.
- **Fonts:** Montserrat (18 variants) and Roboto (14 variants) bundled as assets.
- **Lint rules:** Standard `flutter_lints ^6.0.0` (`package:flutter_lints/flutter.yaml`). No custom overrides.
- **Git submodules:** Clone with `--recurse-submodules`. The external repo (`third_party/ANThology`) is a path dependency in `pubspec.yaml`.

## Dependencies

| Category | Key Packages |
|---|---|
| State management | `provider ^6.1.5+1` |
| Routing | `go_router ^17.2.3` |
| Icons | `cupertino_icons ^1.0.9`, `font_awesome_flutter ^11.0.0` |
| Localization | `intl ^0.20.2` |
| Database | `sqlite3 ^3.3.1` (WASM + native) |
| Shared library | `anthology` (local path: `third_party/ANThology`) |
| Testing | `flutter_test`, `integration_test`, `mockito ^5.7.0` |
| Charts (in shared repo) | `fl_chart ^1.2.0` |
| Markdown (in shared repo) | `markdown ^7.3.1`, `markdown_widget ^2.3.2+8`, `flutter_markdown_plus ^1.0.7` |

## Gotchas

- **No real content locally:** Blog markdown files are downloaded from WebDAV via CI secrets. Running locally will show placeholder/dummy content from `dummy_assets/`.
- **Submodule required:** Always clone with `--recurse-submodules`. Run `flutter pub get` in both root and `third_party/ANThology/`.
- **ARB generation:** After editing `.arb` files, run `flutter gen-l10n` to regenerate `app_localizations*.dart`.
- **SQLite on web:** The `setup-sqlite3-wasm.sh` script must be run to download `sqlite3.wasm` for web targets.
- **iOS/macOS builders:** Do not touch `ios/`, `macos/`, `android/`, `windows/`, `linux/` directories unless specifically requested — they contain platform-specific boilerplate.
- **Known issues:** `flutter_highlighter` needs a patch; `flutter_markdown` has a blockquote rendering issue.
- **ARM64 browser automation:** Playwright's `playwright install chromium` fails on ARM64, but Playwright **works** with `flatpak install flathub org.chromium.Chromium` + `executable_path` to use the flatpak binary.

## CI/CD

- **Trigger:** Push to `main` or `develop`
- **Flow:** Checkout → sync WebDAV content → `flutter pub get` (both dirs) → `dart analyze` → `flutter test` → `flutter build web --release` → FTP deploy
- **main branch:** WASM build deployed to production domain
- **develop branch:** Both WASM and CanvasKit builds deployed to dev domains
- CI: `dart analyze` and `dart format` must pass (zero tolerance) before builds proceed.
