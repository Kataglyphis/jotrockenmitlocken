// Reads web/index.html off disk, so the VM only.
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String? _cachedHtml;

Future<String> _loadWebIndexHtml() async {
  _cachedHtml ??= await File('web/index.html').readAsString();
  return _cachedHtml!;
}

String _extractCsp(String html) {
  final match = RegExp(
    r'<meta[^>]*http-equiv="Content-Security-Policy"[^>]*content="([^"]+)"',
  ).firstMatch(html);
  if (match == null) {
    fail('CSP meta tag not found in web/index.html');
  }
  return match.group(1)!;
}

void main() {
  group('web/index.html — Content Security Policy', () {
    test('contains all required CSP directives', () async {
      final html = await _loadWebIndexHtml();
      final csp = _extractCsp(html);

      expect(csp, contains('default-src'));
      expect(csp, contains('script-src'));
      expect(csp, contains('connect-src'));
      expect(csp, contains('font-src'));
      expect(csp, contains('img-src'));
      expect(csp, contains('style-src'));
      expect(csp, contains('worker-src'));
      expect(csp, contains('media-src'));
    });

    test('names no host besides the site itself', () async {
      // The build serves every engine and font file (--no-web-resources-cdn, Roboto in pubspec.yaml), so nothing else may load.
      final csp = _extractCsp(await _loadWebIndexHtml());

      expect(csp, isNot(contains('https://')));
      expect(csp, isNot(contains('gstatic')));
      expect(csp, isNot(contains('google')));
    });

    test('CSP does NOT use fixed 3-second timer pattern', () async {
      final html = await _loadWebIndexHtml();

      // The fixed setTimeout(3000/3500) after the load event must not come back.
      final hasOldPattern = RegExp(
        r"addEventListener\('load'[\s\S]*3000",
      ).hasMatch(html);
      expect(
        hasOldPattern,
        isFalse,
        reason: 'Fixed 3-second loading timeout must be replaced',
      );
    });
  });

  group('web/ — paths the production Apache serves', () {
    test('no icon under icons/, which Apache aliases to its own', () async {
      // The hub's check-web-artefacts.py --icons-dir app-icons fails the same tree; this names it in the app's own suite.
      final manifest =
          jsonDecode(await File('web/manifest.json').readAsString())
              as Map<String, dynamic>;
      final sources = [
        for (final icon in manifest['icons'] as List<dynamic>)
          (icon as Map<String, dynamic>)['src'] as String,
      ];
      expect(sources, isNotEmpty);
      for (final src in sources) {
        expect(src, startsWith('app-icons/'));
        expect(File('web/$src').existsSync(), isTrue, reason: src);
      }
      final html = await _loadWebIndexHtml();
      expect(html, contains('href="app-icons/Icon-192.png"'));
      expect(html, isNot(contains('/icons/')));
      expect(html, isNot(contains('"icons/')));
      expect(Directory('web/icons').existsSync(), isFalse);
    });

    test('the engine fetches its fallback fonts from this site', () async {
      final bootstrap = await File('web/flutter_bootstrap.js').readAsString();
      final base = RegExp(
        r'fontFallbackBaseUrl:\s*"([^"]*)"',
      ).firstMatch(bootstrap)?.group(1);
      expect(base, 'fallback-fonts/');
      expect(bootstrap, contains('{{flutter_build_config}}'));
    });
  });

  group('web/index.html — the shared shell (ANTfrastructure shared/web/)', () {
    test('a phone gets the viewport, not a 980 px desktop layout', () async {
      expect(
        await _loadWebIndexHtml(),
        contains(
          '<meta name="viewport" content="width=device-width, initial-scale=1">',
        ),
      );
    });

    test('carries the overlay markup dismissBootOverlay() removes', () async {
      final html = await _loadWebIndexHtml();
      expect(html, contains('<div id="background-animation"></div>'));
      expect(html, contains('<div class="loading">'));
      expect(html, contains('<section id="cookie-notice">'));
    });

    test('loads the shell scripts in order, before Flutter', () async {
      final html = await _loadWebIndexHtml();
      final order = [
        'javascript/utils.js',
        'javascript/cookies.js',
        'javascript/init.js',
        'flutter_bootstrap.js',
      ].map((src) => html.indexOf('<script src="$src"')).toList();
      expect(order, isNot(contains(-1)));
      expect(order, orderedEquals([...order]..sort()));
    });

    test('has no inline script, so the CSP needs none', () async {
      final html = await _loadWebIndexHtml();
      expect(RegExp(r'<script>').hasMatch(html), isFalse);
    });
  });
}
