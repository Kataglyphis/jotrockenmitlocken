# Publishing posts

How the content of [jonasheinle.de](https://jonasheinle.de/) is laid out, and how a new blog post
or a post about a book gets on it. Running and building the app: [getting-started.md](getting-started.md).

## Why Markdown and not a CMS

I wanted to publish new content (blog posts, thoughts about books, ...) fast, and without a CMS:

- The content is pure Markdown, so the technology can change at any time; many CMS tie the content
  tightly to their technology. You do not depend on my repo either: you can always switch.
- A native Linux UI would make the effort put into a CMS web blog more or less useless. This
  project is a large reusable part that builds native UIs too (with a Rust backend, for example).
- I want a unique look and feel, so I want full control over the application, which some
  drag-and-drop solutions make difficult.
- I want to learn front-end development and its challenges; just using WordPress does not get you
  there.
- My own [WebDavClient](https://github.com/Kataglyphis/WebDavClient) keeps the content (.md files,
  images, videos, .csv, etc.) private while the source code stays **open source**. To keep your
  data private too, see my [build pipeline file](https://github.com/Kataglyphis/jotrockenmitlocken/blob/develop/.github/workflows/web.yml).

If you like the lightweight Markdown approach, my
[DocumANTation](https://github.com/Kataglyphis/DocumANTation) project converts Markdown to an A4
PDF or to presentation slides.

## Content

All source code is open source, free to use and ready to go. The website data is separate from its
view (MVC best practice): this repo has only the dummy entries, not my blog posts, which are my
intellectual property.

The `assets` directory holds every file the app includes (fonts and the shared images come from
the ANThology package):

- data (.zip, .csv, ...)
- documents (for example .md for blog posts)
- and the settings directory, with the options for your own needs:
  - **global user settings:** customize the blog for you: every user-related option (like email,
    name, image, etc.).
  - All entries in `user_skills_de.json`, `user_skills_en.json` and `user_skills_fr.json` (one per
    language, named in the global user settings) show in the corresponding section.
- **app settings:** the app name and title. The footer can be disabled; the `supportedLocales`
  field takes these values:
  - `["de"]`: build a web app in pure German
  - `["en"]`: build a web app in pure English
  - `["de","en"]` or `["en","de"]`: switch between English and German
  - `["de","en","fr"]` (the committed setting): switch between German, English and French

## Publish a new blog post

- Open `assets/settings/blog_settings.json`.
- Append an entry like this one:

```json
{
		"routingName":"/aiBlog2",
		"shortDescriptionEN":"AI playground 2",
		"shortDescriptionDE":"AI Spielwiese 2",
		"filePath":"assets/documents/blog/aiBlogPageEn.md",
		"imageDir":"assets/images/aiBlog",
		"githubRepo":"MachineLearningAlgorithms",
		"fileTitle": "AIBlog.pdf",
		"fileAdditionalInfo": "PDF version",
		"fileBaseDir": "assets/documents/blog/",
		"lastModified":"03.04.2024",
		"landingPageAlignment":"left",
		"landingPageEntryImagePath": "assets/images/ML_CV.jpeg",
		"landingPageEntryImageCaptioning": "image source: https://pyimagesearch.com/2023/03/30/machine-learning-computer-vision/",
		"docsDesc": [
			{
				"baseDir":"assets/documents/cv/",
				"title":"CV_Jonas_Heinle_english.pdf",
				"additionalInfo": "~3.7MB English"
			},
			{
				"baseDir": "assets/documents/cv/",
				"title": "CV_Jonas_Heinle_german.pdf",
				"additionalInfo": "~3.7MB German"
			},
			{
				"baseDir": "assets/data/",
				"title": "WorleyNoiseTextures.zip",
				"additionalInfo": "Use it for you own projects."
			}
		]
	},
```

- Every file an entry names must be bundled with the app. Flutter bundles only the files directly
  in a directory listed under `flutter: assets:` in `pubspec.yaml`, and the example's
  `assets/documents/blog/` and `assets/images/aiBlog/` are no longer listed (they moved into
  ANThology on 2026-09-07). List your directory there, or name a `packages/anthology/...` asset
  as the committed `blog_settings.json` does. The same holds for the entry below.

## Publish a post about a book

- Open `assets/settings/my_two_cents_settings.json`.
- Add an entry like this one:

```json
{
		"routingName":"/books/fuenfGeheimnisse",
		"filePath":"assets/documents/books/fuenfGeheimnisse.md",
		"imageDir":"assets/images/aiBlog",
		"mediaTitle":"Die fünf Geheimnisse, die Sie entdecken sollten, bevor Sie sterben",
		"fileBaseDir": "assets/documents/books/",
		"docsDesc": [
			{
				"baseDir":"assets/documents/cv/",
				"title":"CV_Jonas_Heinle_english.pdf",
				"additionalInfo": "~3.7MB English"
			},
			{
				"baseDir": "assets/documents/cv/",
				"title": "CV_Jonas_Heinle_german.pdf",
				"additionalInfo": "~3.7MB German"
			},
			{
				"baseDir": "assets/data/",
				"title": "WorleyNoiseTextures.zip",
				"additionalInfo": "Use it for you own projects."
			}
		]
	},
```

- The `mediaTitle` must also appear in `assets/data/Buecherliste_gelesen.csv`.

## Localization

Localized messages are generated from the `.arb` files in `lib/l10n`; `flutter gen-l10n`
regenerates the Dart after an edit ([AGENTS.md § 4](../AGENTS.md#4-pitfalls-specific-to-this-project)).

To support more languages, see
[Internationalizing Flutter apps](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).
