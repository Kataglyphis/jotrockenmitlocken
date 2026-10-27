# jotrockenmitlocken

Guidance for coding agents (and new contributors) working in jotrockenmitlocken.

**Reuse before adding Bash or PowerShell code.** Search this repository and every direct
submodule, including `third_party/ANTfrastructure`, for an existing implementation. Call or
extend its canonical owner, passing project-specific values as arguments. For new behavior
needed by multiple consumers, create or extend one shared owner module and call it here.
Keep unique product logic in this repository.

Keep the shared Flutter artifact gate in Dart checks: it validates the Android manifest and
launcher resources as well as the web assets, even though CI does not build an APK.

## 1. What this project is

Personal blog of Jonas Heinle (@Kataglyphis): a responsive cross-platform Flutter/Dart web app.

- Blog posts are Markdown and private: `scripts/sync-webdav-content.sh` pulls them, and the thesis
  PDFs, off WebDAV at build time.
- Of the content, the tree tracks only the two CV PDFs under `assets/documents/cv/` and the
  settings JSON under `assets/settings/`.
- The samples under `dummy_assets/` are neither bundled nor read by anything.

```
lib/
  main.dart                     # Entry point: removes the web shell's loading overlay (ANThology's dismissBootOverlay), loads the four settings files in parallel through ANThology's SettingsLoader and hands them to KataglyphisAppShell, which builds GoRouter + MaterialApp.router
  Pages/                        # This app's own pages; the shared ones are ANThology's (below)
    jotrockenmitlocken_screen_configurations.dart  # All page config registrations
    AboutMePage/                #   About Me page with skills, charts, donation
    DataPage/                   #   Data sections: books, films, games, quotes (the blog overview and SQLite test routed beside them are ANThology's)
    DocumentsPage/              #   Document download page (CV, thesis PDFs)
  Routing/                      # JotrockenMitLockenRoutes, this app's RoutesCreator: its nav-bar and data pages; footer, blog, review and error pages come from ANThology's helpers
  l10n/                         # ARB-based localization (German + English + French, 15 strings per locale, auto-generated)
web/                            # index.html, manifest.json, flutter_bootstrap.js and app-icons/ are this app's; css/ and javascript/ are the hub's shared shell (§ 4), never edited here
integration_test/performance_test.dart  # Frame timings (start, page switches, resizes) for the perf job; test_driver/perf_driver.dart writes out/perf/frontend.json

scripts/                        # Flat, Linux-only (see § 3); every entry is a thin wrapper, see § 2
third_party/ANThology/ # Git submodule — shared component library
  lib/
    app_attributes.dart         # AppAttributes; AppSettings and UserSettings sit beside it (app_settings.dart, user_settings.dart)
    app_shell.dart              # KataglyphisAppShell: app-wide state, themes, the router and MaterialApp.router
    blog_page_config.dart       # Config models: BlogPageConfig, MyTwoCentsConfig (my_two_cents_config.dart), BlogDependentAppAttributes (blog_dependent_app_attributes.dart)
    Pages/                      # The shared pages; the first five below left this app's lib/Pages on 2026-09-07
      LandingPage/              #   Landing page with blog entry cards
      ErrorPage/                #   404 error page
      Footer/                   #   Footer, its pages and configs (generic_footer_page_config.dart: the parameterized one)
      Home/                     #   Home shell: navigation bar/rail and the trailing actions
      DataPage/BlockOverviewPage/  # Blog overview
      Sqlite/                   #   SQLite self-test page
      markdown_content_page.dart  # Generic Markdown+appendix page (shared)
    Widgets/
      skill_table.dart          #   Reusable JSON-to-Table widget (shared)
    Sqlite/                     #   SQLite loader (FFI natively, sqlite3.wasm on the web), self-test, healthcheck (shared)
    Boot/                       #   dismissBootOverlay(): removes the web shell's loading overlay (shared)
    settings_loader.dart        #   SettingsLoader and the settings parsers (shared)
    Layout/                     # Responsive layout widgets (OneTwoTransitionPage, SinglePage)
    Media/                      # Markdown rendering, file handling, images, data tables
    Routing/                    # Base classes for ScreenConfigurations, RoutesCreator
    Decoration/                 # Visual decoration helpers, charts
    SocialMedia/                # Social media link handling
third_party/ANTfrastructure/    # Git submodule — owns every reusable script, container recipe and build doc
```

## 2. What ANTfrastructure owns — links only

Links only, by the hub's [layout rule](third_party/ANTfrastructure/shared/templates/README.md#what-the-layout-is-for).
Start at [`third_party/ANTfrastructure/docs/INDEX.md`](third_party/ANTfrastructure/docs/INDEX.md),
which maps topic → owning document.

All eleven scripts under `scripts/` are thin wrappers; behaviour that lives upstream is fixed
upstream, never in the wrapper:

| Wrapper | Delegates to |
| --- | --- |
| `scripts/build-in-container.sh` | `linux/scripts/run-in-ci-image.sh` (the container recipe) plus `setup-flutter.sh`, for a Flutter version other than the image's |
| `scripts/ci-container-steps.sh` | the phase switch around the wrappers below (what `.github/workflows/web.yml` runs in the image); the prologue itself is `flutter_lane_prepare_env` / `flutter_build_web`, the `dart-doc` phase `lib/dartdoc-build.sh`'s `dartdoc_build_main` |
| `scripts/run-dart-checks.sh` | shared Flutter format/analyze/test gate (`flutter_checks.sh`) |
| `scripts/integration-smoke-test.sh` | shared Flutter-web smoke test |
| `scripts/run-nginx-integration-test.sh` | `linux/webserver/scripts/flutter-nginx-integration-test.sh`, the nginx harness (hand-run, not in CI; `--port N`); the wrapper only builds when `build/web` is missing and sets this site's CSP hosts |
| `scripts/capture_console_errors.py` | shared Flutter-web console-error test, over every route this site serves without its WebDAV content; a request to a Google host fails it |
| `scripts/check-live-site.py` | `linux/scripts/check-live-site.js`, the check of the deployed site, over the console test's routes plus the posts and reviews `build/web` names, and every file of `build/web` |
| `scripts/run-lint-gates.sh` | shared lint aggregator (`linux/scripts/run-lint-gates.sh`; its header says which gates and why) |
| `scripts/setup-sqlite3-wasm.sh` | shared SHA256-verified sqlite3.wasm fetcher |
| `scripts/renovate-local.sh` | shared Renovate local-CLI dependency updater (every manager the tree has, submodule pins and `pubspec.yaml` included); CI verifies this entrypoint without applying upgrades |
| `scripts/sync-webdav-content.sh` | `01-core/python_uv.sh` (uv, venv) and `01-core/webdav-download.sh` (`webdav_download_tree`, over the `WEBDAVCLIENT_REF` pin in `01-core/versions.env`); only the secret names, the image guard and the destination are this repo's |

| Topic | Where |
| --- | --- |
| Wiring this repo to ANTfrastructure (resolver, actions, libraries) | `docs/adopting-in-a-new-project.md` |
| Flutter-web smoke + console tests | [webserver README](third_party/ANTfrastructure/linux/webserver/README.md#reusable-flutter-web-helpers) |
| Browser prerequisites for the console test | [same README](third_party/ANTfrastructure/linux/webserver/README.md#prerequisites-for-the-browser-smoke-test) |
| Running any command in the family CI image, by hand | `docs/shared-script-libraries.md` § run-in-ci-image.sh |
| Code comments: one line, only the why; API docs short; gated | [the hub rule, Comments](third_party/ANTfrastructure/AGENTS.md#comments-one-line-only-the-why) |
| Searching the tree: `rg`, not `grep -r` | [the hub rule, Searching](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/AGENTS.md#searching-the-tree-ripgrep-rg) |
| CI image reference | `docs/shared-script-libraries.md` § ci-image-ref.sh |
| Dependency updates (Renovate as a local CLI) | `docs/dependency-updates.md` |
| The FTP publish action the deploy steps use | `docs/ftp-deploys.md` |
| The docs site's lane: build, `.htaccess`, link gate, publish (`build-docs.yml`) | `docs/docs-sites.md` |

Two upstream facts that bite before you reach a doc:

- ANTfrastructure's PowerShell modules declare `#requires -Version 7.0`: launch with `pwsh`, never
  `powershell`. This repo's CI is Linux-only today, so it matters only for a new Windows lane.
- Workflows resolve ANTfrastructure's composite actions and reusable workflows at `@develop`, so
  an upstream change a workflow depends on must be pushed **before** the consumer change.

Clone with `--recurse-submodules`. Without the ANTfrastructure submodule, build and lint wrappers
stop with `Error: ANTfrastructure file not found: …`; initialize it with
`git submodule update --init --recursive third_party/ANTfrastructure`. A real
`scripts/renovate-local.sh --apply` initializes the missing hub and other direct submodules;
report and dry-run do not clone.
When WSL opens a Windows Git checkout, the copied bootstrap uses native Git for CRLF-sensitive checks.

## 3. Critical invariant: submodule pins

Builds are only supported against the **recorded submodule gitlinks**, the commits CI builds
green. `git submodule update --checkout --recursive` restores every pin. If a drifted submodule is
what you want, update the gitlink **and** fix the fallout in the same change.

For the newest code instead, `bash third_party/ANTfrastructure/linux/scripts/git-sync-branches.sh`
(`--dry-run` first) puts every checkout on its branch tip:
[`adopting-in-a-new-project.md` § *Putting every checkout on its branch*](third_party/ANTfrastructure/docs/adopting-in-a-new-project.md#putting-every-checkout-on-its-branch).

- `third_party/ANThology` is a path dependency in `pubspec.yaml`; a pin bump must keep
  `flutter pub get` resolving. The go_router lesson: this app declared `go_router ^17.x` while
  ANThology moved to `^18.0.0`; the ranges were disjoint and pub refused the bump. Since
  2026-10-21 `go_router` is back, as a dev dependency at ANThology's and OmniAccelerANT's
  `^18.0.0`, because `test/app_layout_test.dart` reads the router. Move all three together.

ANTfrastructure's shared suite guards drift, run from `.github/workflows/submodule-pins.yml` (its
`pester-version` input pins Pester 3.4.0; the comment above it says why). Run it after any pin
bump. It does **not** check the version coupling above; that is on you.

Flat `scripts/` is deliberate: CI is Linux-only, so there is no `scripts/windows/`; the bootstrap
and its exact Git-mode companion live at `scripts/lib/` per `.antfrastructure-shared.manifest`.

## 4. Pitfalls specific to this project

### Architecture & Conventions

- **State management:** ANThology's `KataglyphisAppShell` holds app-wide state with `setState`.
  Its router survives theme, locale and breakpoint changes; `AppAttributesScope` updates pages
  without discarding their state. Cached asset widgets reload changed paths or locale inputs.
- **Routing:** GoRouter (`package:go_router`, pinned by ANThology) with declarative named routes
- **The web shell is the hub's.** `web/css/` and `web/javascript/` are copies of ANTfrastructure's
  `shared/web/`, declared in `.antfrastructure-shared.manifest`; the lint gates' `shared-config`
  check fails on any edit here. Change them upstream and run
  `sync-shared-config.sh --repo-root . --write` ([`shared/web/README.md`](third_party/ANTfrastructure/shared/web/README.md)).
  `web/.htaccess` is the hub's Apache template under this repo's header (a `body` row).
  `index.html` keeps the shell's markup and script order (`test/unit/web_html_test.dart`), and
  `main()` removes the loading overlay with ANThology's `dismissBootOverlay()`: no JavaScript
  guesses when Flutter is ready.
- **Nothing loads from Google** (owner, 2026-10-21, "Selbst ausliefern"). Every web build passes
  `--no-web-resources-cdn`, so the engine comes from `canvaskit/` on this site, and `pubspec.yaml`
  declares a `Roboto` family (ANThology's TTF, by path), which the engine would otherwise fetch from
  fonts.gstatic.com. The CSP names no other host, and the smoke test (`CHECK_LOCAL_ENGINE`) and
  the console capture (`--forbid-host`) fail on a regression. The engine's fallback fonts come from
  this site too: `web/flutter_bootstrap.js` sets `fontFallbackBaseUrl: "fallback-fonts/"`, and both
  build phases fetch the hub's locked Noto Color Emoji and Noto Sans Symbols 2 chunks there
  ([hub README](third_party/ANTfrastructure/linux/webserver/README.md#fallback-fonts-from-the-site));
  the smoke test's `CHECK_FALLBACK_FONTS` fails a build without them. A glyph outside those (CJK)
  404s from this site, and the live-site check names its URL. The licences page lists their OFL
  notice (`lib/fallback_font_licenses.dart`).
- **The app icons are in `web/app-icons/`, never `web/icons/`.** The production host's Apache
  maps `/icons/` to its own icon directory, so the site's own files there 404 (they did until
  1.4.0). The hub's artefacts gate runs with `--icons-dir app-icons` and fails a `web/icons/`;
  regenerating the icons: [docs/getting-started.md](docs/getting-started.md#app-icons).
- **SQLite has no IndexedDB database here.** `/sqliteTest` runs in memory (ANThology's
  `loadSqlite3()` without a name). A name, once shipped, is permanent: a new one opens an empty
  database in every visitor's browser.
- **Responsive layout:** single-page or two-column layout by screen width breakpoints (defined in `third_party/ANThology/lib/constants.dart`)
- **Content:** Blog posts render through ANThology's `markdown_widget` page. Book/film/game
  reviews use `assets/settings/my_two_cents_settings.json` and ANThology's `MyTwoCentsConfig`.
- **Files:** ANThology's `FileActions` owns browser downloads and native open/save dialogs;
  file buttons report failure through its localized feedback.
- **Widget contracts:** `test/app_layout_test.dart` supplies routes and the app factory to the
  dev-only `anthology_test_support` package inside ANThology. Both apps run the same layout
  cases and tap actual navigation, language and brightness controls.
- **Localization:** ARB files in `lib/l10n/` (template: `app_en.arb`) generate `app_localizations*.dart`. Run `flutter gen-l10n` after every ARB edit; never hand-edit the generated Dart.
- **Page pattern:** every route is a `(page widget, config)` pair, returned by `getAllPagesWithConfigs` in `lib/Routing/jotrockenmitlocken_router.dart`. The config extends ANThology's `StatefulBranchInfoProvider`, which supplies only `getRoutingName()`; nav-bar configs (`NavBarPageConfig`) add the `NavigationDestination` (icon and label), and ANThology's `RoutesCreator` builds the GoRouter from the pairs.
- **Fonts:** Montserrat and Roboto come from the anthology package (the note closing `pubspec.yaml`).
- **Lint rules:** `flutter_lints` via the shared include `third_party/ANTfrastructure/shared/config/analysis_options.yaml`. No custom overrides.
- **Format scope:** `dart format` runs over `git ls-files '*.dart'`, never `.`: a recursive walk format-checks `third_party/ANThology` ([hub § *`dart format`: the tracked files*](third_party/ANTfrastructure/docs/code-quality-tooling.md#dart-format-the-tracked-files-in-the-floors-style)).

### Dependencies

| Category | Key Packages |
|---|---|
| Routing | `go_router ^18.0.0` (ANThology's; a dev dependency here for the layout test) |
| Icons | `cupertino_icons ^2.0.0`, `font_awesome_flutter ^11.0.0` |
| Localization | `intl ^0.20.2` |
| Database | `sqlite3 ^3.7.0` (WASM + native; `web/sqlite3.wasm` is the same release) |
| Shared library | `anthology` (local path: `third_party/ANThology`) |
| Testing | `flutter_test`, `integration_test`, ANThology's dev-only `anthology_test_support` |
| Charts (in shared repo) | `fl_chart ^1.2.0` |
| Markdown (in shared repo) | `markdown_widget ^2.3.2+8` |

### Gotchas

- **No real content locally:** local runs show the anthology package's bundled sample blog and empty tables until `scripts/sync-webdav-content.sh` populates `assets/` (needs the four WebDAV repository secrets).
- **SQLite on web:** `bash scripts/setup-sqlite3-wasm.sh` downloads `sqlite3.wasm` into `web/` for web targets. It takes no arguments: the version and its SHA256 come from ANTfrastructure's `linux/scripts/01-core/versions.env` (`SQLITE3_WASM_VERSION`), and the download is verified against it.
- **Platform directories:** do not touch `ios/`, `macos/`, `android/`, `windows/`, `linux/` unless asked; they hold platform-specific boilerplate.
- **Android follows OmniAccelerANT's setup:** AGP 9.4.1, Gradle 9.8.1 and AGP's built-in Kotlin (`android.builtInKotlin=true`, no `kotlin-android` plugin; the KGP in `android/settings.gradle.kts` is declared, never applied, to clear Flutter's Kotlin floor). The image's `/opt/android-sdk` is read-only, so `android/build.gradle.kts` pins compileSdk, build-tools and NDK to what it ships, for every plugin too; Flutter's own NDK default is not in it. No CI lane builds the APK: `flutter build apk --release` in the family image is the check (passed 2026-10-13).
- **Historical Markdown patch notes:** [docs/getting-started.md](docs/getting-started.md#known-issues).
- **ARM64 browser automation:** Playwright's `playwright install chromium` fails on ARM64; flatpak Chromium works everywhere. The prerequisites and the four failures worth recognising are ANTfrastructure's — § E2E prerequisites below.

### CI/CD (`.github/workflows/web.yml`)

- **Names** follow the family's [workflow naming](third_party/ANTfrastructure/docs/adopting-in-a-new-project.md#workflow-file-names-and-display-names) (owner decision 2026-09-24): this lane is `web.yml` "Web · build + deploy" (`dart.yml` until then), the pin lane `submodule-pins.yml` "Submodule pins". Job ids did not change, so neither did the check-run names.
- **Trigger:** push to `main` or `develop`, never a PR. The family's [CI-round rule](third_party/ANTfrastructure/docs/branch-and-release-strategy.md) does not reach this repo: it has no platform lane to request ([`ci-build-triggers.md`](third_party/ANTfrastructure/docs/ci-build-triggers.md#the-consumer-lanes)). Flow: lint gates → WebDAV sync → dart-checks (format, analyze, VM tests with coverage, the `lib/` floor of 74 %, the suites again in Chrome, the hub's web artefacts gate) → `flutter build web --release --wasm --no-web-resources-cdn` → fallback fonts into `build/web/fallback-fonts/` → smoke test (it also checks the shared shell, the local engine and the fallback fonts) → FTP deploy. `main` deploys WASM to the production domain; `develop` deploys WASM and CanvasKit to the dev domains.
- **Live-site check:** after `main`'s upload, `scripts/check-live-site.py https://jonasheinle.de` loads every route in Chrome and fails on a console error, a CSP block, a third-party host, a file of `build/web` not served with 200, or a `version.json` that is not the build's. It cannot undo the upload: red means the site is broken now. `develop` has no check: the dev domains are secret and no secret holds their URL.
- **Frame timings:** the `perf` job, beside `build` and gated on neither, runs
  `integration_test/performance_test.dart` on the Linux profile build under Xvfb
  (`ci-container-steps.sh perf`). The hub's `frontend-perf-report` action compares it with the
  median of `develop`'s last 20 runs: +25 % warns, a doubled average or 90th-percentile build
  time fails once 3 runs exist.
- **Docs site:** the `docs` job, beside `build` and gated on neither, calls the hub's [`build-docs.yml`](third_party/ANTfrastructure/docs/docs-sites.md) with `command: bash scripts/ci-container-steps.sh dart-doc`. That phase builds `doc/api` (`dart doc`, the family theme, both `docs/` guides); the hub adds its `.htaccess` and 404 page, fails on a dead internal link or anchor, and publishes to the docs domain the README links, with the `DOC_WEBSITE_*` secrets.
- **Containerised lane:** every Dart/Flutter step runs in the family Linux CI image (Flutter at `/opt/flutter`, no `setup-flutter`) via ANTfrastructure's `prepare-linux-ci-host` and `run-in-linux-container` actions. The image tag is deliberately written nowhere in this repo: the steps omit `image:` and inherit the actions' default (the comment at the top of the `build` job says why). Each step is a fresh container, so `scripts/ci-container-steps.sh` re-establishes PATH, git `safe.directory` and the pub cache (`.pub-cache/` in the workspace) per phase, through ANTfrastructure's `flutter_lane_prepare_env`, not a prologue of its own.
- **Host-side steps:** the lint gate job (`build` needs it, so a lint failure stops the deploy before it starts) and the three web-app FTP deploy steps. The repo has no `GHCR_PAT`: the prologue action skips login and pulls the public image anonymously.
- **The WebDAV sync runs in the image** (owner, 2026-10-20: only the image's pinned CPython, no interpreter download): `run-in-linux-container` gets the four secrets through the step's `env:` and hands them on by name (`-e WEBDAV_PASSWORD`), so no value is on a command line; the fetched assets land in the bind-mounted workspace. Outside the image the script stops with exit 2.

### E2E prerequisites (Playwright + flatpak Chromium)

Not in CI: `scripts/capture_console_errors.py` launches a real headless browser to capture console
logs, page errors and runtime exceptions. It delegates to ANTfrastructure's
`flutter_capture_console_errors.py`, and the prerequisites are upstream's too:

- the install commands, and why `--break-system-packages` rather than a venv:
  [Prerequisites for the browser smoke test](third_party/ANTfrastructure/linux/webserver/README.md#prerequisites-for-the-browser-smoke-test);
- the four failures that each look like something else, including the one where the test passes
  against the OLD build:
  [Troubleshooting the browser smoke test](third_party/ANTfrastructure/linux/webserver/README.md#troubleshooting-the-browser-smoke-test).

This repo's own line: `flatpak install flathub org.mozilla.firefox` is optional, only for
eyeballing the site by hand; nothing here drives Firefox.

## 5. Build, run, test

```bash
# The whole Dart gate — pub get (root + ANThology), format, analyze, test.
# Thin wrapper over ANTfrastructure's flutter_checks.sh; CI runs this exact script.
bash scripts/run-dart-checks.sh

# What else CI's dart-checks phase runs: the coverage floor, the suites in Chrome, the web artefacts gate
bash scripts/ci-container-steps.sh dart-checks

# Frame timings on the Linux profile build (Xvfb), then the table CI writes
bash scripts/ci-container-steps.sh perf
python3 third_party/ANTfrastructure/linux/scripts/05-frameworks/flutter/frontend-perf-report.py out/perf/frontend.json

# The individual steps, when you want only one of them
flutter pub get && (cd third_party/ANThology && flutter pub get)
dart analyze
flutter test
dart format --output=none --set-exit-if-changed $(git ls-files '*.dart')   # not `dart format .`, see § 4

# CI's first gates on every commit, by reference (the hub's hook, never a copy)
git config core.hooksPath third_party/ANTfrastructure/shared/linux/templates/git-hooks

# The whole lint gate; which gates and why is the header of
# third_party/ANTfrastructure/linux/scripts/run-lint-gates.sh. CI's `lint` job
# (ANTfrastructure's reusable lint lane) runs that same aggregator with the same
# arguments, not this wrapper, and `build` (the deploy job) will not start until
# it passes.
bash scripts/run-lint-gates.sh

# Dependency upgrades, not a gate: third_party/ANTfrastructure/docs/dependency-updates.md.
# Dependabot is off (owner, 2026-10-20), so this is the only dependency watch.
bash scripts/renovate-local.sh                    # report what is behind
bash scripts/renovate-local.sh --apply --dry-run  # the plan
bash scripts/renovate-local.sh --apply            # move the gitlinks, edit the manifests

# Pull the private blog content off WebDAV into assets/ (needs the four
# credentials CI holds as repository secrets), in the family image as CI runs it.
WEBDAV_HOSTNAME=... WEBDAV_USERNAME=... WEBDAV_PASSWORD=... WEBDAV_REMOTE_BASE_PATH=... \
  docker run --rm -e WEBDAV_HOSTNAME -e WEBDAV_USERNAME -e WEBDAV_PASSWORD -e WEBDAV_REMOTE_BASE_PATH \
  -v "$PWD:/workspace" -w /workspace ghcr.io/kataglyphis/kataglyphis_beschleuniger:latest \
  bash scripts/sync-webdav-content.sh

# Local web dev (no real blog content without WebDAV secrets)
flutter run -d web-server --profile --web-port 8080 --web-hostname 0.0.0.0

# Build web release (always --wasm; CanvasKit is the fallback bundle only)
flutter build web --release --wasm --no-web-resources-cdn --no-tree-shake-icons
flutter build web --release --no-web-resources-cdn --no-tree-shake-icons

# E2E, both against a fresh WASM build — run both before committing, exit 0 or do not commit
bash scripts/run-nginx-integration-test.sh   # HTTP-level smoke test, nginx in docker/nerdctl (ENGINE; --port N) (or: serve build/web on :8080, then bash scripts/integration-smoke-test.sh http://localhost:8080)
python3 scripts/capture_console_errors.py    # browser console error capture (prerequisites in § 4)

# Generate localization code from ARB files
flutter gen-l10n

# The docs site as the docs job builds it (in the image), then its .htaccess, 404 page and link gate
bash scripts/ci-container-steps.sh dart-doc
bash third_party/ANTfrastructure/linux/scripts/docs-site.sh stage doc/api
```

> **MANDATORY for agents:** after any code change, `bash scripts/run-dart-checks.sh` must pass
> with zero errors; fix and re-run until it does. CI runs the same script with zero tolerance on
> `dart analyze` and `dart format`, and a failure blocks the deploy.

## 6. Docs owned by this repo

**Write docs like a developer: short and precise** (owner, 2026-10-19). Say what a thing does,
how to run it and what breaks; no filler, no marketing, no repetition.

| Doc | Holds |
| --- | --- |
| `README.md` | The overview, in the family's [README shape](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/docs/repository-family.md#the-readme-rule). `dart doc` renders it as the docs site's front page, so its links into this repo are absolute GitHub URLs |
| `docs/getting-started.md` | Running it locally, where the commands are, the known issues, the literature |
| `docs/publishing-posts.md` | The user-facing story: why Markdown, the content layout, how to publish a post or a review, localization |
| `lib/l10n/*.arb` | The localized strings (§ 4, *Localization*) |

- Both `docs/` pages are also on the docs site, as `guide-getting-started.html` and
  `guide-publishing-posts.html`: the `dart-doc` phase lists them in `DARTDOC_BUILD_GUIDES`. A new
  page goes into that list and into the README's documentation table. A relative link to a
  non-Markdown file is dead on the site (the renderer rewrites only `*.md` links), so link such a
  file by its GitHub URL.
- A change to user-facing behaviour updates its page in the same PR.
- A page that restates a hub page fails the lint gates (`doc-dupes --against-hub`): link to the hub
  instead. A passage that must stay is budgeted in `doc-dupes-hub.allow`, with its reason.
