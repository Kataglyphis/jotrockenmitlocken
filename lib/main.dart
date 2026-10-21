import 'package:flutter/material.dart';

import 'package:anthology/Boot/boot_overlay.dart';
import 'package:anthology/Pages/Footer/default_footer_config.dart';
import 'package:anthology/Pages/Home/default_home_config.dart';
import 'package:anthology/app_settings.dart';
import 'package:anthology/app_shell.dart';
import 'package:anthology/blog_dependent_app_attributes.dart';
import 'package:anthology/blog_page_config.dart';
import 'package:anthology/my_two_cents_config.dart';
import 'package:anthology/settings_loader.dart';
import 'package:anthology/user_settings.dart';

import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlocken/Routing/jotrockenmitlocken_router.dart';
import 'package:jotrockenmitlocken/fallback_font_licenses.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';

/// Everything read off the asset bundle before the first frame: the shared three and the media reviews.
typedef SettingsLoadResult = (
  AppSettings,
  UserSettings,
  List<BlogPageConfig>,
  List<MyTwoCentsConfig>,
);

const String userSettingsFilePath =
    "assets/settings/user_settings/global_user_settings.json";
const String appSettingsFilePath = "assets/settings/app_settings.json";
const String blogSettingsFilePath = "assets/settings/blog_settings.json";
const String twoCentsSettingsFilePath =
    "assets/settings/my_two_cents_settings.json";

/// Loads all four settings files in parallel; a bad or missing file is logged and rethrown.
Future<SettingsLoadResult> loadAppSettings([SettingsLoader? loader]) async {
  final SettingsLoader settings = loader ?? SettingsLoader();
  final List<Object> results = await Future.wait<Object>([
    settings.loadShared(
      userSettingsPath: userSettingsFilePath,
      appSettingsPath: appSettingsFilePath,
      blogSettingsPath: blogSettingsFilePath,
    ),
    settings.load(twoCentsSettingsFilePath, parseMyTwoCentsConfigs),
  ]);
  final (appSettings, userSettings, blogConfigs) = results[0] as SharedSettings;
  return (
    appSettings,
    userSettings,
    blogConfigs,
    results[1] as List<MyTwoCentsConfig>,
  );
}

void main() {
  dismissBootOverlay();
  registerFallbackFontLicenses();
  runApp(const App());
}

/// This app's half of [KataglyphisAppShell]: its settings loader, localizations and screens.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KataglyphisAppShell<SettingsLoadResult>(
      loadBootstrapData: loadAppSettings,
      appLocalizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
      ],
      buildBinding:
          (SettingsLoadResult data, KataglyphisAppShellRuntime runtime) {
            final (appSettings, userSettings, blogConfigs, twoCentsConfigs) =
                data;

            final JotrockenmitLockenScreenConfigurations screenConfigurations =
                JotrockenmitLockenScreenConfigurations.fromBlogAndDataConfigs(
                  blogPageConfigs: blogConfigs,
                  twoCentsConfigs: twoCentsConfigs,
                );

            return KataglyphisAppShellBinding(
              appAttributes: runtime.buildAppAttributes(
                footerConfig: DefaultFooterConfig(),
                homeConfig: DefaultHomeConfig(),
                appSettings: appSettings,
                userSettings: userSettings,
                screenConfigurations: screenConfigurations,
              ),
              routesCreator: JotrockenMitLockenRoutes(
                blogDependentAppAttributes: BlogDependentAppAttributes(
                  blogDependentScreenConfigurations: screenConfigurations,
                  twoCentsConfigs: twoCentsConfigs,
                  blockSettings: blogConfigs,
                ),
              ),
            );
          },
    );
  }
}
