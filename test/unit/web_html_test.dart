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

String _extractInlineLoadingScript(String html) {
  final scripts = RegExp(
    r'<script>\s*([\s\S]*?)\s*</script>',
    multiLine: true,
  ).allMatches(html).toList();
  expect(
    scripts.length,
    greaterThanOrEqualTo(1),
    reason: 'Expected at least one inline <script> block',
  );
  return scripts.last.group(1)!;
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

    test('script-src allows gstatic.com for CanvasKit JS', () async {
      final csp = _extractCsp(await _loadWebIndexHtml());

      expect(
        csp,
        matches(RegExp(r'script-src[^;]*https://www\.gstatic\.com')),
        reason: 'CanvasKit JS must be loadable from gstatic.com',
      );
    });

    test('connect-src allows gstatic.com and fonts.gstatic.com', () async {
      final csp = _extractCsp(await _loadWebIndexHtml());

      expect(
        csp,
        matches(RegExp(r'connect-src[^;]*https://www\.gstatic\.com')),
        reason: 'CanvasKit WASM must be fetchable from gstatic.com',
      );
      expect(
        csp,
        matches(RegExp(r'connect-src[^;]*https://fonts\.gstatic\.com')),
        reason: 'Google Fonts must be fetchable',
      );
    });

    test('font-src allows fonts.gstatic.com', () async {
      final csp = _extractCsp(await _loadWebIndexHtml());

      expect(
        csp,
        matches(RegExp(r'font-src[^;]*https://fonts\.gstatic\.com')),
        reason: 'Google Fonts must be allowed as font source',
      );
    });

    test('CSP does NOT use fixed 3-second timer pattern', () async {
      final html = await _loadWebIndexHtml();

      // The old buggy code had: setTimeout(..., 3000) and setTimeout(..., 3500)
      // right after window.addEventListener('load', ...)
      // The new code should NOT have load + 3000/3500 pattern
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

  group('web/index.html — Loading screen JS', () {
    test('uses MutationObserver to detect Flutter render', () async {
      final script = _extractInlineLoadingScript(await _loadWebIndexHtml());

      expect(
        script,
        contains('MutationObserver'),
        reason: 'Must watch DOM for Flutter elements',
      );
      expect(
        script,
        contains('observer.disconnect()'),
        reason: 'Must clean up observer to prevent memory leaks',
      );
    });

    test('has hideLoading function with guard', () async {
      final script = _extractInlineLoadingScript(await _loadWebIndexHtml());

      expect(
        script,
        contains('function hideLoading()'),
        reason: 'hideLoading function must be defined',
      );
      expect(
        script,
        contains("classList.add('fade-out')"),
        reason: 'Must use CSS fade-out transition',
      );
      expect(
        script,
        contains('hidden = true'),
        reason: 'Must guard against multiple calls',
      );
    });

    test('has fallback timeout (not infinite loading)', () async {
      final script = _extractInlineLoadingScript(await _loadWebIndexHtml());

      expect(
        script,
        contains('setTimeout'),
        reason: 'Must have fallback timeout to hide loading',
      );
    });

    test('detects element nodes (nodeType === 1)', () async {
      final script = _extractInlineLoadingScript(await _loadWebIndexHtml());

      expect(
        script,
        contains('nodeType === 1'),
        reason: 'Must check for Element nodes, not text/comment nodes',
      );
    });
  });
}
