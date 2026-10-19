# jotrockenmitlocken

Guidance for coding agents (and new contributors) working in jotrockenmitlocken.

## 1. What this project is

Personal blog of Jonas Heinle (@Kataglyphis): a responsive cross-platform Flutter/Dart web app.

- Blog posts are Markdown and private: `scripts/sync-webdav-content.sh` pulls them, and the thesis
  PDFs, off WebDAV at build time.
- Of the content, the tree tracks only the two CV PDFs under `assets/documents/cv/` and the
  settings JSON under `assets/settings/`.
- The samples under `dummy_assets/` are neither bundled nor read by anything.

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
[`third_party/ANTfrastructure/docs/INDEX.md`](third_party/ANTfrastructure/docs/INDEX.md): it maps
topic → owning document, so links survive upstream reorganisation. Where anything belongs: *would
this still be true in a different project?* Yes → ANTfrastructure owns it, link to it. No → write
it out here.

All ten scripts under `scripts/` are thin wrappers; behaviour that lives upstream is fixed
upstream, never in the wrapper:

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
| Code comments: one line, only the why; API docs short; gated | [the hub rule, Comments](third_party/ANTfrastructure/AGENTS.md#comments-one-line-only-the-why) |
| Searching the tree: `rg`, not `grep -r` | [the hub rule, Searching](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/AGENTS.md#searching-the-tree-ripgrep-rg) |
| CI image reference | `docs/shared-script-libraries.md` § ci-image-ref.sh |
| Dependency updates (Renovate as a local CLI) | `docs/dependency-updates.md` |
| The FTP publish action the deploy steps use | `docs/ftp-deploys.md` |

Two upstream facts that bite before you reach a doc:

- ANTfrastructure's PowerShell modules declare `#requires -Version 7.0`: launch with `pwsh`, never
  `powershell`. This repo's CI is Linux-only today, so it matters only for a new Windows lane.
- Workflows resolve ANTfrastructure's composite actions and reusable workflows at `@develop`, so
  an upstream change a workflow depends on must be pushed **before** the consumer change.

Clone with `--recurse-submodules`. Without the ANTfrastructure submodule the wrappers stop with
`Error: ANTfrastructure file not found: …` and the command that fixes it
(`git submodule update --init --recursive third_party/ANTfrastructure`).

## 3. Critical invariant: submodule pins

Builds are only supported against the **recorded submodule gitlinks**, the commits CI builds
green. `git submodule update --checkout --recursive` restores every pin. If a drifted submodule is
what you want, update the gitlink **and** fix the fallout in the same change.

The opposite move, for local work on the newest code, is
`bash third_party/ANTfrastructure/linux/scripts/git-sync-branches.sh` (`--dry-run` first): this
repo and every submodule, third-party ones included, go to the tip of their `branch =`,
fast-forward only; `--owned-only` leaves the third-party ones pinned. It commits no gitlink, so
what it moved shows as `+` until the gitlinks are committed, innermost repo first, and the next
`git submodule update` puts it back.
Details: [`adopting-in-a-new-project.md` § *Putting every checkout on its branch*](third_party/ANTfrastructure/docs/adopting-in-a-new-project.md#putting-every-checkout-on-its-branch).

- `third_party/ANThology` is a path dependency in `pubspec.yaml`; a pin bump must keep
  `flutter pub get` resolving. The go_router lesson: this app declared `go_router ^17.x` while
  ANThology moved to `^18.0.0`; the ranges were disjoint, pub refused the bump, and since the app
  never imported it, the direct dependency is gone. Do not re-add a package ANThology already
  pins unless the ranges overlap.

ANTfrastructure's shared suite guards drift, run from `.github/workflows/submodule-pins.yml` (its
`pester-version` input pins Pester 3.4.0; the comment above it says why). Run it after any pin
bump. It does **not** check the version coupling above; that is on you.

Flat `scripts/` is deliberate: CI is Linux-only, so there is no `scripts/windows/`; the bootstrap
copy lives at `scripts/lib/` per `.antfrastructure-shared.manifest`.

## 4. Pitfalls specific to this project

### Architecture & Conventions

- **State management:** plain `StatefulWidget` state — ANThology's `KataglyphisAppShell` holds the app-wide state and changes it with `setState`. `provider` is declared in `pubspec.yaml` but imported nowhere (nor by ANThology).
- **Routing:** GoRouter (`package:go_router`, pinned by ANThology) with declarative named routes
- **Responsive layout:** single-page or two-column layout by screen width breakpoints (defined in `third_party/ANThology/lib/constants.dart`)
- **Content:** Blog posts in Markdown, rendered via `markdown_widget` (ANThology's `lib/Media/Markdown/markdown_page.dart`; `flutter_markdown_plus` is declared there but imported nowhere). Book/film/game reviews via `assets/settings/my_two_cents_settings.json` (parsed into ANThology's `MyTwoCentsConfig`).
- **Localization:** ARB files in `lib/l10n/` (template: `app_en.arb`) generate `app_localizations*.dart`. Run `flutter gen-l10n` after every ARB edit; never hand-edit the generated Dart.
- **Page pattern:** every route is a `(page widget, config)` pair, returned by `getAllPagesWithConfigs` in `lib/Routing/jotrockenmitlocken_router.dart`. The config extends ANThology's `StatefulBranchInfoProvider`, which supplies only `getRoutingName()`; nav-bar configs (`NavBarPageConfig`) add the `NavigationDestination` (icon and label), and ANThology's `RoutesCreator` builds the GoRouter from the pairs.
- **Fonts:** Montserrat and Roboto come from the anthology package (the note closing `pubspec.yaml`).
- **Lint rules:** `flutter_lints` via the shared include `third_party/ANTfrastructure/shared/config/analysis_options.yaml`. No custom overrides.
- **Format scope:** `dart format` runs over `git ls-files '*.dart'`, never `.` — a recursive walk format-checks `third_party/ANThology`; see `third_party/ANTfrastructure/docs/code-quality-tooling.md` § Dart file enumeration.

### Dependencies

| Category | Key Packages |
|---|---|
| State management | `provider ^6.1.5+1` (declared, imported nowhere) |
| Routing | `go_router ^18.0.0` (through `anthology`; no direct dependency here) |
| Icons | `cupertino_icons ^2.0.0`, `font_awesome_flutter ^11.0.0` |
| Localization | `intl ^0.20.2` |
| Database | `sqlite3 ^3.7.0` (WASM + native; `web/sqlite3.wasm` is the same release) |
| Shared library | `anthology` (local path: `third_party/ANThology`) |
| Testing | `flutter_test`, `integration_test`, `mockito ^5.7.0` |
| Charts (in shared repo) | `fl_chart ^1.2.0` |
| Markdown (in shared repo) | `markdown ^7.3.1`, `markdown_widget ^2.3.2+8`, `flutter_markdown_plus ^1.0.7` (declared; only `markdown_widget` is imported) |

### Gotchas

- **No real content locally:** local runs show the anthology package's bundled sample blog and empty tables until `scripts/sync-webdav-content.sh` populates `assets/` (needs the four WebDAV repository secrets).
- **SQLite on web:** `bash scripts/setup-sqlite3-wasm.sh` downloads `sqlite3.wasm` into `web/` for web targets. It takes no arguments: the version and its SHA256 come from ANTfrastructure's `linux/scripts/01-core/versions.env` (`SQLITE3_WASM_VERSION`), and the download is verified against it.
- **Platform directories:** do not touch `ios/`, `macos/`, `android/`, `windows/`, `linux/` unless asked; they hold platform-specific boilerplate.
- **Android follows OmniAccelerANT's setup:** AGP 9.4.1, Gradle 9.8.1 and AGP's built-in Kotlin (`android.builtInKotlin=true`, no `kotlin-android` plugin; the KGP in `android/settings.gradle.kts` is declared, never applied, to clear Flutter's Kotlin floor). The image's `/opt/android-sdk` is read-only, so `android/build.gradle.kts` pins compileSdk, build-tools and NDK to what it ships, for every plugin too; Flutter's own NDK default is not in it. No CI lane builds the APK: `flutter build apk --release` in the family image is the check (passed 2026-10-13).
- **Known issues** (`flutter_highlighter`'s patch, the 2024 `flutter_markdown` blockquote note): [docs/getting-started.md](docs/getting-started.md#known-issues).
- **ARM64 browser automation:** Playwright's `playwright install chromium` fails on ARM64; flatpak Chromium works everywhere. The prerequisites and the four failures worth recognising are ANTfrastructure's — § E2E prerequisites below.

### CI/CD (`.github/workflows/web.yml`)

- **Names** follow the family convention (owner decision 2026-09-24): kebab-case, one file per platform, display names `<Platform> · <what>`, shared lanes named the same in every repo. This lane is `web.yml` "Web · build + deploy" (`dart.yml` until then), the pin lane `submodule-pins.yml` "Submodule pins". Job ids did not change, so neither did the check-run names.
- **Trigger:** push to `main` or `develop`. Flow: lint gates → WebDAV sync → dart-checks → `flutter build web --release --wasm` → smoke test → FTP deploy. `main` deploys WASM to the production domain; `develop` deploys WASM and CanvasKit to the dev domains. Both branches then build the API docs (`dart doc`, the `dart-doc` phase) and publish them to the docs domain the README links; the `docs/` guides are read on GitHub, outside that build.
- **Containerised lane:** every Dart/Flutter step runs in the family Linux CI image (Flutter at `/opt/flutter`, no `setup-flutter`) via ANTfrastructure's `prepare-linux-ci-host` and `run-in-linux-container` actions. The image tag is deliberately written nowhere in this repo: the steps omit `image:` and inherit the actions' default (the comment at the top of the `build` job says why). Each step is a fresh container, so `scripts/ci-container-steps.sh` re-establishes PATH, git `safe.directory` and the pub cache (`.pub-cache/` in the workspace) per phase, through ANTfrastructure's `flutter_lane_prepare_env`, not a prologue of its own.
- **Host-side steps:** the lint gate job (`build` needs it, so a lint failure stops the deploy before it starts), the WebDAV sync (repo secrets + uv; the fetched assets land in the workspace the container bind-mounts) and the four FTP deploy steps. The repo has no `GHCR_PAT`: the prologue action skips login and pulls the public image anonymously.

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

- Both `docs/` pages are read on GitHub, not on the docs site: the `dart-doc` phase runs a bare
  `dart doc`, which publishes only the README and the API. A new page goes into the README's
  documentation table.
- A change to user-facing behaviour updates its page in the same PR.
