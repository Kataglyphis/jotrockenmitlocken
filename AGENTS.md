# jotrockenmitlocken

Guidance for coding agents (and new contributors) working in jotrockenmitlocken.

## 1. What this project is

Personal blog as a responsive cross-platform Flutter/Dart web app by Jonas Heinle (@Kataglyphis). Blog posts are written in Markdown and kept private: `scripts/sync-webdav-content.sh` pulls them off WebDAV at build time, so of the content the tree tracks only the CV/thesis PDFs under `assets/documents/` and the settings JSON under `assets/settings/`. The samples under `dummy_assets/` are neither bundled nor read by anything.

```
lib/
  main.dart                     # Entry point: loads the JSON settings in parallel (settings_loader.dart) and hands them to ANThology's KataglyphisAppShell, which builds GoRouter + MaterialApp.router
  Pages/                        # This app's own pages; the shared ones are ANThology's (below)
    jotrockenmitlocken_screen_configurations.dart  # All page config registrations
    AboutMePage/                #   About Me page with skills, charts, donation
    DataPage/                   #   Data sections: books, films, games, quotes (the blog overview and SQLite test routed beside them are ANThology's)
    DocumentsPage/              #   Document download page (CV, thesis PDFs)
  Routing/                      # JotrockenMitLockenRoutes, this app's RoutesCreator: pairs every page with its config
  l10n/                         # ARB-based localization (German + English + French, 15 strings per locale, auto-generated)
  settings_loader.dart          # Loads the four settings files; the config models it fills are ANThology's

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
    Sqlite/                     #   Platform-conditional SQLite self-test (shared)
    Layout/                     # Responsive layout widgets (OneTwoTransitionPage, SinglePage)
    Media/                      # Markdown rendering, file handling, images, data tables
    Routing/                    # Base classes for ScreenConfigurations, RoutesCreator
    Decoration/                 # Visual decoration helpers, charts
    SocialMedia/                # Social media link handling
third_party/ANTfrastructure/    # Git submodule — owns every reusable script, container recipe and build doc
```

## 2. What ANTfrastructure owns — links only

**Do not restate upstream procedures here.** Start at
[`third_party/ANTfrastructure/docs/INDEX.md`](third_party/ANTfrastructure/docs/INDEX.md)
— it maps topic → owning document, so links survive upstream reorganisation. The
rule that decides where anything belongs: *would this still be true in a
different project?* Yes → ANTfrastructure owns it, link to it. No → write it out
here.

All ten scripts under `scripts/` are thin wrappers — editing the wrapper when
the behaviour lives upstream is the mistake to avoid:

| Wrapper | Delegates to |
| --- | --- |
| `scripts/build-in-container.sh` | `linux/scripts/run-in-ci-image.sh` (the container recipe) plus `setup-flutter.sh`, for a Flutter version other than the image's |
| `scripts/ci-container-steps.sh` | the phase switch around the wrappers below (what `.github/workflows/web.yml` runs in the image); the prologue itself is `flutter_lane_prepare_env` / `flutter_build_web` |
| `scripts/run-dart-checks.sh` | shared Flutter format/analyze/test gate (`flutter_checks.sh`) |
| `scripts/integration-smoke-test.sh` | shared Flutter-web smoke test |
| `scripts/run-nginx-integration-test.sh` | local docker/nginx harness (hand-run, not in CI); readiness is `01-core/http-readiness.sh`'s `wait_for_http` |
| `scripts/capture_console_errors.py` | shared Flutter-web console-error test |
| `scripts/run-lint-gates.sh` | shared lint aggregator (`linux/scripts/run-lint-gates.sh`; its header says which gates and why) |
| `scripts/setup-sqlite3-wasm.sh` | shared SHA256-verified sqlite3.wasm fetcher |
| `scripts/renovate-local.sh` | shared Renovate local-CLI dependency updater (every manager the tree has, submodule pins and `pubspec.yaml` included) |
| `scripts/sync-webdav-content.sh` | `01-core/python_uv.sh` (uv, venv) and `01-core/webdav-download.sh` (`webdav_download_tree`, over the `WEBDAVCLIENT_REF` pin in `01-core/versions.env`); only the secret names, the interpreter and the destination are this repo's |

| Topic | Where |
| --- | --- |
| Wiring this repo to ANTfrastructure (resolver, actions, libraries) | `docs/adopting-in-a-new-project.md` |
| Flutter-web smoke + console tests | [webserver README](third_party/ANTfrastructure/linux/webserver/README.md#reusable-flutter-web-helpers) |
| Browser prerequisites for the console test | [same README](third_party/ANTfrastructure/linux/webserver/README.md#prerequisites-for-the-browser-smoke-test) |
| Running any command in the family CI image, by hand | `docs/shared-script-libraries.md` § run-in-ci-image.sh |
| CI image reference | `docs/shared-script-libraries.md` § ci-image-ref.sh |
| Dependency updates (Renovate as a local CLI) | `docs/dependency-updates.md` |
| The FTP publish action the deploy steps use | `docs/ftp-deploys.md` |

Two upstream facts worth knowing before you reach a doc:

- ANTfrastructure's PowerShell modules declare `#requires -Version 7.0` — launch
  with `pwsh`, never `powershell`. (Not used by this repo's CI today, which is
  Linux-only, but true if you add a Windows lane.)
- Workflows resolve ANTfrastructure's composite actions and reusable workflows at
  `@develop`, so an upstream change a workflow depends on must be pushed
  **before** the consumer change.

Clone with `--recurse-submodules`. Without the ANTfrastructure submodule the
wrappers stop with `Error: ANTfrastructure file not found: …` and the command
that fixes it (`git submodule update --init --recursive third_party/ANTfrastructure`)
rather than a confusing error.

## 3. Critical invariant: submodule pins

Builds are only supported against the **recorded submodule gitlinks** — the commits
CI builds green. `git submodule update --checkout --recursive` restores every pin. If
a drifted submodule is what you actually want, update the gitlink **and** fix the
fallout in the same change.

- `third_party/ANThology` is a path dependency in `pubspec.yaml`; a pin bump must
  keep `flutter pub get` resolving. The go_router lesson: this app declared
  `go_router ^17.x` while ANThology moved to `^18.0.0` — disjoint ranges, pub
  refused the bump, and the app never imported it, so the direct dependency is
  gone. Do not re-add a package ANThology already pins unless the ranges overlap.

Drift is guarded by ANTfrastructure's shared suite, run from
`.github/workflows/submodule-pins.yml` (its header records the Pester version it
was measured against). Run it after any pin bump. It does **not** check the
version coupling above; that is on you.

Flat `scripts/` is deliberate: CI is Linux-only, so there is no
`scripts/windows/`; the bootstrap copy lives at `scripts/lib/` per
`.antfrastructure-shared.manifest`.

## 4. Pitfalls specific to this project

### Architecture & Conventions

- **State management:** plain `StatefulWidget` state — ANThology's `KataglyphisAppShell` holds the app-wide state and changes it with `setState`. `provider` is declared in `pubspec.yaml` but imported nowhere (nor by ANThology).
- **Routing:** GoRouter (`package:go_router`, pinned by ANThology) with declarative named routes
- **Responsive layout:** Switch between single-page and two-column layout based on screen width breakpoints (defined in `third_party/ANThology/lib/constants.dart`)
- **Content:** Blog posts in Markdown, rendered via `markdown_widget` (ANThology's `lib/Media/Markdown/markdown_page.dart`; `flutter_markdown_plus` is declared there but imported nowhere). Book/film/game reviews via `assets/settings/my_two_cents_settings.json` (parsed into ANThology's `MyTwoCentsConfig`).
- **Localization:** ARB files in `lib/l10n/` (template: `app_en.arb`), output auto-generated to `app_localizations.dart`. Always run `flutter gen-l10n` after editing ARB files.
- **Page pattern:** every route is a `(page widget, config)` pair, returned by `getAllPagesWithConfigs` in `lib/Routing/jotrockenmitlocken_router.dart`. The config extends ANThology's `StatefulBranchInfoProvider`, which supplies only `getRoutingName()`; nav-bar configs (`NavBarPageConfig`) add the `NavigationDestination` (icon and label), and ANThology's `RoutesCreator` builds the GoRouter from the pairs.
- **Fonts:** Montserrat and Roboto come from the anthology package (the note closing `pubspec.yaml`).
- **Lint rules:** `flutter_lints` via the shared include `third_party/ANTfrastructure/shared/config/analysis_options.yaml`. No custom overrides.
- **Format scope:** `dart format` runs over `git ls-files '*.dart'`, never `.` — a recursive walk format-checks `third_party/ANThology`; see `third_party/ANTfrastructure/docs/code-quality-tooling.md` § Dart file enumeration.

### Dependencies

| Category | Key Packages |
|---|---|
| State management | `provider ^6.1.5+1` (declared, imported nowhere) |
| Routing | `go_router ^18.0.0` (through `anthology`; no direct dependency here) |
| Icons | `cupertino_icons ^1.0.9`, `font_awesome_flutter ^11.0.0` |
| Localization | `intl ^0.20.2` |
| Database | `sqlite3 ^3.3.1` (WASM + native) |
| Shared library | `anthology` (local path: `third_party/ANThology`) |
| Testing | `flutter_test`, `integration_test`, `mockito ^5.7.0` |
| Charts (in shared repo) | `fl_chart ^1.2.0` |
| Markdown (in shared repo) | `markdown ^7.3.1`, `markdown_widget ^2.3.2+8`, `flutter_markdown_plus ^1.0.7` (declared; only `markdown_widget` is imported) |

### Gotchas

- **No real content locally:** local runs show the anthology package's bundled sample blog and empty tables until `scripts/sync-webdav-content.sh` populates `assets/` (needs the four WebDAV repository secrets).
- **Submodule required:** Always clone with `--recurse-submodules`. Run `flutter pub get` in both root and `third_party/ANThology/`.
- **ARB generation:** After editing `.arb` files, run `flutter gen-l10n` to regenerate `app_localizations*.dart`.
- **SQLite on web:** `bash scripts/setup-sqlite3-wasm.sh` downloads `sqlite3.wasm` into `web/` for web targets. It takes no arguments: the version and its SHA256 come from ANTfrastructure's `linux/scripts/01-core/versions.env` (`SQLITE3_WASM_VERSION`), and the download is verified against it.
- **iOS/macOS builders:** Do not touch `ios/`, `macos/`, `android/`, `windows/`, `linux/` directories unless specifically requested — they contain platform-specific boilerplate.
- **Known issues:** `flutter_highlighter` needs a patch (ANThology still declares it; nothing in its `lib/` imports it). The `flutter_markdown` blockquote issue in the README is from 2024; `flutter_markdown` is no longer a dependency, and Markdown renders through `markdown_widget`.
- **ARM64 browser automation:** Playwright's `playwright install chromium` fails on ARM64; flatpak Chromium works everywhere. The prerequisites and the four failures worth recognising are ANTfrastructure's now — see § E2E prerequisites below.

### CI/CD (`.github/workflows/web.yml`)

- **Names:** the family convention (owner decision 2026-09-24) — kebab-case, one file per platform, display names `<Platform> · <what>`, shared lanes named the same in every repo. So this lane is `web.yml` "Web · build + deploy" (it was `dart.yml` until then), and the pin lane is `submodule-pins.yml` "Submodule pins". Job ids did not change, so neither did the check-run names.
- **Trigger:** push to `main` or `develop`. Flow: lint gates → WebDAV sync → dart-checks → `flutter build web --release --wasm` → smoke test → FTP deploy. `main` deploys WASM to the production domain; `develop` deploys WASM and CanvasKit to the dev domains. Both branches then build the API docs (`dart doc`, the `dart-doc` phase) and publish them to the docs domain the README links.
- **Containerised lane:** every Dart/Flutter step runs in the family Linux CI image (Flutter at `/opt/flutter`, no `setup-flutter`) via ANTfrastructure's `prepare-linux-ci-host` and `run-in-linux-container` actions. The image tag is deliberately written nowhere in this repo: the steps omit `image:` and inherit the actions' default (the comment at the top of the `build` job says why). Each step is a fresh container, so `scripts/ci-container-steps.sh` re-establishes PATH, git `safe.directory` and the pub cache (`.pub-cache/` in the workspace) per phase — through ANTfrastructure's `flutter_lane_prepare_env`, not a prologue of its own.
- **Host-side steps:** the lint gate job (`build` needs it, so a lint failure stops the deploy before it starts), the WebDAV sync (repo secrets + uv; the fetched assets land in the workspace the container bind-mounts) and the four FTP deploy steps. The repo has no `GHCR_PAT`: the prologue action skips login and pulls the public image anonymously.

### E2E prerequisites (Playwright + flatpak Chromium)

Not in CI: `scripts/capture_console_errors.py` launches a real headless browser to capture console logs, page errors and runtime exceptions. It delegates to ANTfrastructure's `flutter_capture_console_errors.py`, and the prerequisites are upstream's too: the install commands and why `--break-system-packages` rather than a venv are in
[Prerequisites for the browser smoke test](third_party/ANTfrastructure/linux/webserver/README.md#prerequisites-for-the-browser-smoke-test),
and the four failures that each look like something else — including the one where the test passes against the OLD build — are in
[Troubleshooting the browser smoke test](third_party/ANTfrastructure/linux/webserver/README.md#troubleshooting-the-browser-smoke-test).

The one line that is this repo's: `flatpak install flathub org.mozilla.firefox` is optional and only for eyeballing the site by hand; nothing here drives Firefox.

## 5. Build, run, test

```bash
# The whole Dart gate — pub get (root + ANThology), format, analyze, test.
# Thin wrapper over ANTfrastructure's flutter_checks.sh; CI runs this exact script.
bash scripts/run-dart-checks.sh

# The individual steps, when you want only one of them
flutter pub get && (cd third_party/ANThology && flutter pub get)
dart analyze
flutter test
dart format --output=none --set-exit-if-changed $(git ls-files '*.dart')   # not `dart format .`, see § 4

# The whole lint gate; which gates and why is the header of
# third_party/ANTfrastructure/linux/scripts/run-lint-gates.sh. CI's `lint` job
# (ANTfrastructure's reusable lint lane) runs that same aggregator with the same
# arguments, not this wrapper, and `build` (the deploy job) will not start until
# it passes.
bash scripts/run-lint-gates.sh

# Dependency upgrades — Renovate as a local CLI over every manager this tree
# has: the two submodule gitlinks, pubspec.yaml and the rest the hub script
# detects (dependabot still covers pubspec.yaml too). Not a gate. It bootstraps
# its own pinned, checksum-verified Node on Linux x64/arm64; on Windows run it
# from WSL. third_party/ANTfrastructure/docs/dependency-updates.md
bash scripts/renovate-local.sh                    # report what is behind
bash scripts/renovate-local.sh --apply --dry-run  # the plan, with pre-flight
bash scripts/renovate-local.sh --apply            # move the gitlinks, edit the manifests

# Pull the private blog content off WebDAV into assets/ (needs the four
# credentials CI holds as repository secrets). CI runs this exact script.
WEBDAV_HOSTNAME=... WEBDAV_USERNAME=... WEBDAV_PASSWORD=... \
  WEBDAV_REMOTE_BASE_PATH=... bash scripts/sync-webdav-content.sh

# Local web dev (no real blog content without WebDAV secrets)
flutter run -d web-server --profile --web-port 8080 --web-hostname 0.0.0.0

# Build web release (always --wasm; CanvasKit is the fallback bundle only)
flutter build web --release --wasm --no-tree-shake-icons
flutter build web --release --no-tree-shake-icons

# E2E, both against a fresh WASM build — run both before committing, exit 0 or do not commit
bash scripts/run-nginx-integration-test.sh   # HTTP-level smoke test (or: serve build/web on :8080, then bash scripts/integration-smoke-test.sh http://localhost:8080)
python3 scripts/capture_console_errors.py    # browser console error capture (prerequisites in § 4)

# Generate localization code from ARB files
flutter gen-l10n
```

> **MANDATORY for agents:** After making any code changes, you MUST run `bash scripts/run-dart-checks.sh` and it MUST pass with zero errors. If it fails, fix the issues and re-run before considering the task complete. The CI pipeline runs this same script and enforces zero tolerance on `dart analyze` and `dart format` — failures block deployment.

## 6. Docs owned by this repo

- `README.md` — the user-facing story: content layout, how to publish a post or a review, localization. A change to user-facing behaviour updates it in the same PR.
- `lib/l10n/*.arb` — the localized strings; `app_en.arb` is the template, and every edit is followed by `flutter gen-l10n` (the generated Dart is not hand-edited).
