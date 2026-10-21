# Getting started

Running jotrockenmitlocken locally, where the build and test commands are, and the known issues.
How the content is laid out and published: [publishing-posts.md](publishing-posts.md).

## Prerequisites

Flutter ([online documentation](https://flutter.dev/docs)). CI takes Flutter from the family Linux
image, not from a local install ([AGENTS.md § 4](../AGENTS.md#cicd-githubworkflowswebyml)).

## Run the web server locally for debugging

```bash
git clone --recurse-submodules --branch develop https://github.com/Kataglyphis/jotrockenmitlocken.git
cd jotrockenmitlocken
flutter run -d web-server --profile --web-port 8080 --web-hostname 0.0.0.0
```

> **Note**: a local run shows only the sample blog that ships with the ANThology package; the
> book/film/... critics and data tables stay empty. Their source content .md files are my
> intellectual property and visible only to me. The Flutter/Dart source code is **open source**.

CI pulls that content off WebDAV before it builds (`scripts/sync-webdav-content.sh`, with the four
WebDAV credentials it holds as repository secrets).

## Build, test, dependency upgrades

Every command is in [AGENTS.md § 5](../AGENTS.md#5-build-run-test): the Dart gate CI runs, the
lint gates, the content sync, the WASM and CanvasKit web builds, the two end-to-end tests,
`flutter gen-l10n`, and Renovate as a local CLI over every dependency manager this tree has (the
two submodule gitlinks in `.gitmodules` and `pubspec.yaml` among them). Why Renovate runs as a
local CLI, and the full workflow:
[ANTfrastructure's `dependency-updates.md`](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/docs/dependency-updates.md).

## App icons

The web icons live in `web/app-icons/`, not Flutter's `web/icons/`: the production host's Apache
maps `/icons/` to its own icon directory, so every file there answered 404. The hub's web
artefacts gate fails a `web/icons/` again ([`failure-modes.md`](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/docs/failure-modes.md)).
`flutter_launcher_icons` writes only `web/icons/`, so its web generator is off. To regenerate the
web icons from `assets/icons/kataglyphis_app_icon.png`:

1. Set `flutter_launcher_icons: web: generate: true` in `pubspec.yaml` and run
   `dart run flutter_launcher_icons`.
2. Move its output: `mv web/icons/* web/app-icons/ && rmdir web/icons`.
3. Restore `web/manifest.json` and `pubspec.yaml` (`git checkout -- web/manifest.json pubspec.yaml`):
   the generator points the manifest back at `icons/`.
4. Re-encode the PNGs to 8 bits, as the artefacts gate's message says.

## Known issues

- `flutter_highlighter` needs line 94 changed from `RichText` to `Text.rich` to make it
  selectable; its developer does not want to integrate the feature. ANThology still declares it,
  but nothing in either `lib/` imports it.
- `flutter_markdown` (note from 2024): not in a stable version. I edited its blockquote section by
  hand to centre it, and upstream had an open issue on building a `MarkdownBuilder` for a
  blockquote. Markdown now renders through `markdown_widget`, and `flutter_markdown` is no longer
  a dependency.

## Literature

Flutter/Dart:

- [Johannes Milke](https://www.youtube.com/@JohannesMilke)
- [Package repository for Dart and Flutter apps](https://pub.dev/)
- [Official Flutter web example](https://flutter.github.io/samples/material_3.html)
