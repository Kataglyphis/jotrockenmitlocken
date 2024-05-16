import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/button_names.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/home_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JotrockenMitLockenHomeConfig extends HomeConfig {
  @override
  ButtonNames getButtonNames(BuildContext context) {
    return ButtonNames(
        brightness: AppLocalizations.of(context)!.toogleBrightness,
        color: AppLocalizations.of(context)!.selectSeedColor,
        language: AppLocalizations.of(context)!.switchLang);
  }
}
