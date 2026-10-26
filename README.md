<div align="center">
  <a href="https://jonasheinle.de">
    <img src="images/logo.svg" alt="jotrockenmitlocken logo: a curly-haired ant with a speech bubble" width="200" />
  </a>

  <h1>jotrockenmitlocken</h1>

  <h4>My personal blog as a responsive Flutter/Dart web app, every post in plain Markdown.</h4>
</div>

[![Web · build + deploy](https://github.com/Kataglyphis/jotrockenmitlocken/actions/workflows/web.yml/badge.svg)](https://github.com/Kataglyphis/jotrockenmitlocken/actions/workflows/web.yml)
[![CodeQL](https://github.com/Kataglyphis/jotrockenmitlocken/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/Kataglyphis/jotrockenmitlocken/actions/workflows/github-code-scanning/codeql)
[![TopLang](https://img.shields.io/github/languages/top/Kataglyphis/jotrockenmitlocken)]()
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/paypalme/JonasHeinle)
[![Twitter](https://img.shields.io/twitter/follow/Cataglyphis_?style=social)](https://twitter.com/Cataglyphis_)
[![YouTube](https://img.shields.io/youtube/channel/subscribers/UC3LZiH4sZzzaVBCUV8knYeg?style=social)](https://www.youtube.com/channel/UC3LZiH4sZzzaVBCUV8knYeg)

[**Docs site**](https://holdmydocs.jonasheinle.de)

The Flutter app behind [jonasheinle.de](https://jonasheinle.de/): blog posts, book and film
reviews, data tables and downloadable documents. A post is a Markdown file and a page is a JSON
entry, so new content needs no code. The content is private and fetched from WebDAV at build
time; the code is open source, its reusable widgets live in
[ANThology](https://github.com/Kataglyphis/ANThology). Targets: web, Linux, Windows, Android, iOS.

Dependency updates: run `bash scripts/renovate-local.sh` to report, `--apply --dry-run` to plan,
and `--apply` to update. CI checks the wrapper and config; see
[the shared Renovate guide](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/docs/dependency-updates.md).

## Highlights

- **Posts without code:** Markdown files, pages configured in JSON.
- **Reviews:** books and films, each a post.
- **Rendering:** Markdown pages, `.csv` data as tables.
- **Downloads:** CV, thesis and other files to open or save.
- **Three languages:** de, en, fr.
- **Retained pages:** language, theme and window-size changes keep the selected page and its state.
- **Private content, open code:** content arrives through [WebDavClient](https://github.com/Kataglyphis/WebDavClient).

## Quick start

```bash
git clone --recurse-submodules --branch develop https://github.com/Kataglyphis/jotrockenmitlocken.git
cd jotrockenmitlocken
flutter run -d web-server --profile --web-port 8080 --web-hostname 0.0.0.0
```

A local run shows only the sample blog that ships with ANThology. Prerequisites, the build and
the tests: [docs/getting-started.md](https://github.com/Kataglyphis/jotrockenmitlocken/blob/develop/docs/getting-started.md).

## Documentation

| Topic | Read |
| --- | --- |
| The API | [holdmydocs.jonasheinle.de](https://holdmydocs.jonasheinle.de) |
| Getting started: run, build, test, dependency upgrades, known issues, literature | [docs/getting-started.md](https://github.com/Kataglyphis/jotrockenmitlocken/blob/develop/docs/getting-started.md) |
| CI quality reports, Ruff/ty and refactor previews | [Shared quality tooling](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/docs/code-quality-tooling.md) |
| Publishing posts: why Markdown, the content layout, a blog post, a book, localization | [docs/publishing-posts.md](https://github.com/Kataglyphis/jotrockenmitlocken/blob/develop/docs/publishing-posts.md) |
| Rules for agents and contributors, including shared Bash/PowerShell reuse | [AGENTS.md](https://github.com/Kataglyphis/jotrockenmitlocken/blob/develop/AGENTS.md) |

## Contributing and contact

jotrockenmitlocken is one of the [Kataglyphis repositories](https://github.com/Kataglyphis/ANTfrastructure/blob/develop/docs/repository-family.md),
which share one way to contribute and one contact. Licence: MIT, see [LICENSE](https://github.com/Kataglyphis/jotrockenmitlocken/blob/develop/LICENSE).
