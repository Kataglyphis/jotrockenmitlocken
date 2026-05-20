# jotrockenmitlocken

Personal blog as a responsive cross-platform Flutter/Dart web app by Jonas Heinle (@Kataglyphis). Blog posts are written in Markdown, kept private via WebDAV — only the Flutter/Dart source code is open-source.

## Build, Lint & Test

```bash
# Install dependencies (root + external submodule)
flutter pub get && cd external/jotrockenmitlockenrepo && flutter pub get && cd -

# Lint & analyze (zero tolerance for errors)
dart analyze

# Check formatting
dart format --output=none --set-exit-if-changed .

# Run tests
flutter test

# Local web dev (no real blog content without WebDAV secrets)
flutter run -d web-server --profile --web-port 8080 --web-hostname 0.0.0.0

# Build web release (default: WASM)
flutter build web --release --wasm --no-tree-shake-icons

# Build web release (CanvasKit fallback, for non-WASM browsers)
flutter build web --release --no-tree-shake-icons

CRITICAL: Always build with `--wasm`. The CanvasKit build is only a fallback for browsers that don't support WASM.

# Generate localization code from ARB files
flutter gen-l10n
```

**Verification order:** `dart analyze` → `flutter test` → `dart format --output=none --set-exit-if-changed .`

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
  l10n/                         # ARB-based localization (German + English, 53 strings, auto-generated)
  *.dart                        # Config models: BlogPageConfig, MyTwoCentsConfig, BlogDependentAppAttributes, settings_loader

external/jotrockenmitlockenrepo/ # Git submodule — shared component library
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
- **Responsive layout:** Switch between single-page and two-column layout based on screen width breakpoints (defined in `external/jotrockenmitlockenrepo/lib/constants.dart`)
- **Content:** Blog posts in Markdown, rendered via `markdown_widget` / `flutter_markdown_plus`. Book/film/game reviews via `my_two_cents_config.json`.
- **Localization:** ARB files in `lib/l10n/` (template: `app_en.arb`), output auto-generated to `app_localizations.dart`. Always run `flutter gen-l10n` after editing ARB files.
- **Page pattern:** Each page implements `StatefulBranchInfoProvider` (from shared repo) which provides `getRoutingName()` and a GoRouter-compatible page builder. Config classes hold route metadata, icon, label, and page builder.
- **Fonts:** Montserrat (18 variants) and Roboto (14 variants) bundled as assets.
- **Lint rules:** Standard `flutter_lints ^6.0.0` (`package:flutter_lints/flutter.yaml`). No custom overrides.
- **Git submodules:** Clone with `--recurse-submodules`. The external repo (`external/jotrockenmitlockenrepo`) is a path dependency in `pubspec.yaml`.

## Dependencies

| Category | Key Packages |
|---|---|
| State management | `provider ^6.1.5+1` |
| Routing | `go_router ^17.2.3` |
| Icons | `cupertino_icons ^1.0.9`, `font_awesome_flutter ^11.0.0` |
| Localization | `intl ^0.20.2` |
| Database | `sqlite3 ^3.3.1` (WASM + native) |
| Shared library | `jotrockenmitlockenrepo` (local path: `external/jotrockenmitlockenrepo`) |
| Testing | `flutter_test`, `integration_test`, `mockito ^5.7.0` |
| Charts (in shared repo) | `fl_chart ^1.2.0` |
| Markdown (in shared repo) | `markdown ^7.3.1`, `markdown_widget ^2.3.2+8`, `flutter_markdown_plus ^1.0.7` |

## Gotchas

- **No real content locally:** Blog markdown files are downloaded from WebDAV via CI secrets. Running locally will show placeholder/dummy content from `dummy_assets/`.
- **Submodule required:** Always clone with `--recurse-submodules`. Run `flutter pub get` in both root and `external/jotrockenmitlockenrepo/`.
- **ARB generation:** After editing `.arb` files, run `flutter gen-l10n` to regenerate `app_localizations*.dart`.
- **SQLite on web:** The `setup_sqlite3_wasm.sh` script must be run to download `sqlite3.wasm` for web targets.
- **iOS/macOS builders:** Do not touch `ios/`, `macos/`, `android/`, `windows/`, `linux/` directories unless specifically requested — they contain platform-specific boilerplate.
- **Known issues:** `flutter_highlighter` needs a patch; `flutter_markdown` has a blockquote rendering issue.

## CI/CD

- **Trigger:** Push to `main` or `develop`
- **Flow:** Checkout → sync WebDAV content → `flutter pub get` (both dirs) → `dart analyze` → `flutter test` → `flutter build web --release` → FTP deploy
- **main branch:** WASM build deployed to production domain
- **develop branch:** Both WASM and CanvasKit builds deployed to dev domains
- `dart analyze` and `dart format` are `continue-on-error` in CI so formatting issues don't block deployment, but fix them anyway.
