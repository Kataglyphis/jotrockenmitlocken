# Publishing posts

How the content of [jonasheinle.de](https://jonasheinle.de/) is laid out, and how a new blog
post or a post about a book gets on it. Running and building the app: [getting-started.md](getting-started.md).

## Why Markdown and not a CMS

I always wanted an easy way to publish new content (blog posts, thoughts about books, ...) fast.
But why not just use a CMS? Here are my reasons:

- As the content is pure Markdown, my approach allows me to always change the technology
  easily; many CMS integrate the content very strongly into their technology.
  - Therefore you will not make yourself dependent on my repo. You are always able to switch.
- What if I want to build a UI for a native Linux application? Then all effort brought into
  building a web blog with a CMS is more or less useless. With this project I have a very huge
  reusable part that lets me build native UIs too (with a Rust backend, for example).
- I want a very unique look and feel for my website. Therefore I want all power over my
  application, which can be difficult with some drag-and-drop solutions.
- I want to learn front-end development and its challenges. Just using WordPress won't bring
  you there.
- I developed my own [WebDavClient](https://github.com/Kataglyphis/WebDavClient), which allows
  me to keep the content (.md files, images, videos, .csv, etc.) private while the source code
  stays **open source**. You might also be interested in **keeping your data private**. Have a
  look into my [build pipeline file](../.github/workflows/web.yml) for more information.

If you also love the lightweight Markdown approach, you might be interested in my
[DocumANTation](https://github.com/Kataglyphis/DocumANTation) project, which even converts
Markdown to an A4 PDF or to presentation slides.

## Content

I truly believe in open source. Hence you get all source code for free use and ready to go.
My approach separates the website data from its view (MVC best practice). You will not see my
blog posts (only the dummy entries) in this repo. They are my intellectual property.

The `assets` directory houses all files you want to include within your application (fonts and
the shared images come from the ANThology package):

- data (.zip, .csv, ...)
- documents (for example .md for blog posts)
- and the settings directory, which harbors many different options for your own needs:
  - **global user settings:** here you can easily customize the blog for you. Set all
    necessary user-related options (like email, name, image, etc.).
  - All entries in `user_skills_de.json`, `user_skills_en.json` and `user_skills_fr.json` (one
    per language, named in the global user settings) are displayed in the corresponding
    section.
- **app settings:** set the app name and title. You are able to disable the footer; the
  `supportedLocales` field can have the following values:
  - `["de"]`: build a web app in pure German
  - `["en"]`: build a web app in pure English
  - `["de","en"]` or `["en","de"]`: switch between English and German
  - `["de","en","fr"]` (the committed setting): switch between German, English and French

## Publish a new blog post

To add a new blog post:

- Open the file `assets/settings/blog_settings.json`.
- Append an entry like the following:

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

- Every file an entry names must be bundled with the app. Flutter bundles only the files lying
  directly in a directory listed under `flutter: assets:` in `pubspec.yaml`, and
  `assets/documents/blog/` and `assets/images/aiBlog/` from the example are not listed any more
  (they moved into ANThology on 2026-09-07). Either list your directory there, or name a
  `packages/anthology/...` asset as the committed `blog_settings.json` does. The same holds for
  the entry below.

## Publish a post about a book

- Open the file `assets/settings/my_two_cents_settings.json`.
- Add an entry like the following:

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

- Make sure that the `mediaTitle` you add here is available in the
  `assets/data/Buecherliste_gelesen.csv` file.

## Localization

This project generates localized messages based on the `.arb` files in the `lib/l10n`
directory; `flutter gen-l10n` regenerates the Dart after an edit
([AGENTS.md § 4](../AGENTS.md#4-pitfalls-specific-to-this-project)).

To support additional languages, see the tutorial on
[Internationalizing Flutter apps](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).
