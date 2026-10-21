// The settings main() reads before the first frame, as shipped; VM only, as a Chrome test serves no app assets to rootBundle.
@TestOn('vm')
library;

import 'package:anthology/SocialMedia/Settings/social_media_settings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'the shipped settings load, and every blog post names an asset that exists',
    () async {
      final (appSettings, userSettings, blogConfigs, twoCentsConfigs) =
          await loadAppSettings();

      expect(
        appSettings.supportedLocales,
        unorderedEquals(
          AppLocalizations.supportedLocales.map((l) => l.languageCode),
        ),
        reason:
            'a language the app offers must have its translations, and the other way round',
      );

      final routes = <String>[
        ...blogConfigs.map((c) => c.routingName),
        ...twoCentsConfigs.map((c) => c.routingName),
      ];
      expect(
        routes.toSet(),
        hasLength(routes.length),
        reason: 'two pages on one route: $routes',
      );
      expect(routes, everyElement(startsWith('/')));

      expect(blogConfigs, isNotEmpty);
      for (final config in blogConfigs) {
        final ByteData post = await rootBundle.load(config.filePath);
        expect(post.lengthInBytes, greaterThan(0), reason: config.filePath);
      }

      // A network without an icon in ANThology renders as an empty footer button.
      expect(socialNetworksWithoutIcon(userSettings), isEmpty);
    },
  );
}
