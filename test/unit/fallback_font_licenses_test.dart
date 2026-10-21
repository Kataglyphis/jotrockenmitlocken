import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jotrockenmitlocken/fallback_font_licenses.dart';

/// A bundle that serves one text, so the entry's shape is tested apart from the asset.
class _TextBundle extends CachingAssetBundle {
  _TextBundle(this.text);

  final String text;
  final List<String> asked = <String>[];

  @override
  Future<ByteData> load(String key) async {
    asked.add(key);
    return ByteData.sublistView(Uint8List.fromList(text.codeUnits));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'the entry names both Noto fallback fonts and carries the notice',
    () async {
      final bundle = _TextBundle('OFL text');
      final entries = await fallbackFontLicenses(bundle).toList();
      expect(entries, hasLength(1));
      expect(entries.single.packages, [
        'Noto Color Emoji',
        'Noto Sans Symbols 2',
      ]);
      expect(entries.single.paragraphs.single.text, 'OFL text');
      expect(bundle.asked, [fallbackFontLicensePath]);
    },
  );

  test(
    'the bundled notice is the OFL with both copyright lines',
    () async {
      final text = await rootBundle.loadString(fallbackFontLicensePath);
      expect(text, contains('SIL OPEN FONT LICENSE Version 1.1'));
      expect(text, contains('Noto Color Emoji: Copyright 2013 Google LLC'));
      expect(
        text,
        contains(
          'Noto Sans Symbols 2: Copyright 2022 The Noto Project Authors',
        ),
      );
    },
    // The framework's NOTICES collector and Chrome's asset server are not what this pins.
    testOn: 'vm',
  );

  test('main() registers the entry with LicenseRegistry', () async {
    addTearDown(LicenseRegistry.reset);
    registerFallbackFontLicenses();
    final collected = await LicenseRegistry.licenses
        .where((entry) => entry.packages.contains('Noto Sans Symbols 2'))
        .first
        .timeout(const Duration(seconds: 10));
    expect(collected.packages, contains('Noto Color Emoji'));
  }, testOn: 'vm');
}
