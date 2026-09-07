import 'package:flutter/material.dart';

import 'package:anthology/Pages/Footer/default_footer_config.dart';
import 'package:anthology/Pages/Home/default_home_config.dart';
import 'package:anthology/app_shell.dart';
import 'package:anthology/blog_dependent_app_attributes.dart';

import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlocken/Routing/jotrockenmitlocken_router.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/settings_loader.dart';

const String userSettingsFilePath =
    "assets/settings/user_settings/global_user_settings.json";
const String appSettingsFilePath = "assets/settings/app_settings.json";
const String blogSettingsFilePath = "assets/settings/blog_settings.json";
const String twoCentsSettingsFilePath =
    "assets/settings/my_two_cents_settings.json";

/// Loads this app's settings through its own [SettingsLoader], which logs and
/// rethrows on a malformed or missing file.
Future<SettingsLoadResult> loadAppSettings() {
  return SettingsLoader().loadAll(
    userSettingsPath: userSettingsFilePath,
    appSettingsPath: appSettingsFilePath,
    blogSettingsPath: blogSettingsFilePath,
    twoCentsSettingsPath: twoCentsSettingsFilePath,
  );
}

void main() {
  runApp(const App());
}

/// jotrockenmitlocken's half of the shared shell.
///
/// Everything that used to live here - the animation controller, the width
/// breakpoints, the four `handle*` callbacks, the theme pair and the
/// `FutureBuilder -> MaterialApp.router` tail - now lives once in
/// [KataglyphisAppShell]. What is left is genuinely this app's: its
/// [SettingsLoader], its generated `AppLocalizations` and its screen
/// configurations.
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
