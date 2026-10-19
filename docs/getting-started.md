# Getting started

How to run jotrockenmitlocken locally, where the build and test commands are, and the known
issues. How the content is laid out and published: [publishing-posts.md](publishing-posts.md).

## Prerequisites

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on
mobile development, and a full API reference. CI takes Flutter from the family Linux image, not
from a local install ([AGENTS.md § 4](../AGENTS.md#cicd-githubworkflowswebyml)).

## Run the web server locally for debugging

```bash
git clone --recurse-submodules --branch develop https://github.com/Kataglyphis/jotrockenmitlocken.git
cd jotrockenmitlocken
flutter run -d web-server --profile --web-port 8080 --web-hostname 0.0.0.0
```

> **Note**: If you run this website locally, you only see the sample blog that ships with the
> ANThology package, and the book/film/... critics and data tables stay empty. Their source
> content .md files are my intellectual property and therefore only visible to me. The
> Flutter/Dart source code stays **open source**, of course.

CI pulls that content off WebDAV before it builds (`scripts/sync-webdav-content.sh`, with the
four WebDAV credentials it holds as repository secrets).

## Build, test, dependency upgrades

Every command is in [AGENTS.md § 5](../AGENTS.md#5-build-run-test): the Dart gate CI runs, the
lint gates, the content sync, the WASM and CanvasKit web builds, the two end-to-end tests,
`flutter gen-l10n`, and Renovate as a local CLI over every dependency manager this tree has (the
two submodule gitlinks in `.gitmodules` and `pubspec.yaml` among them). Why Renovate runs as a
local CLI, and the full workflow:
[ANTfrastructure's `dependency-updates.md`](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/docs/dependency-updates.md).

## Known issues

`flutter_highlighter` needs an update in line 94 from `RichText` to `Text.rich` to make it
selectable. The developer just doesn't want to integrate the feature. ANThology still declares
it, but nothing in either `lib/` imports it.

`flutter_markdown` is not in a very stable version. I had to manually edit the blockquote section
for centering it. At the time of writing this they have an open issue on not being able to build
a `MarkdownBuilder` for a blockquote. (That note is from 2024; Markdown now renders through
`markdown_widget`, and `flutter_markdown` is no longer a dependency.)

## Literature

Some very helpful literature, tutorials, etc.

Flutter/Dart:

- [Johannes Milke](https://www.youtube.com/@JohannesMilke)
- [Package repository for Dart and Flutter apps](https://pub.dev/)
- [Official Flutter web example](https://flutter.github.io/samples/material_3.html)
