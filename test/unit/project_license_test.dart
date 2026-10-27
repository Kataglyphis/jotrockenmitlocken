import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jotrockenmitlocken/project_license.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'the bundled licence is the repository LICENSE, byte for byte',
    () async {
      final String bundled = await rootBundle.loadString(projectLicensePath);
      expect(bundled, File('LICENSE').readAsStringSync());
      expect(bundled, contains('MIT License'));
    },
    // Reads the checkout; a browser test serves no files.
    testOn: 'vm',
  );

  test('registerProjectLicense lists the app under its own licence', () async {
    addTearDown(LicenseRegistry.reset);
    registerProjectLicense();
    final LicenseEntry entry = await LicenseRegistry.licenses
        .firstWhere(
          (LicenseEntry e) => e.packages.contains(projectLicensePackage),
        )
        .timeout(const Duration(seconds: 10));
    expect(entry.paragraphs.first.text, contains('MIT License'));
  }, testOn: 'vm');
}
