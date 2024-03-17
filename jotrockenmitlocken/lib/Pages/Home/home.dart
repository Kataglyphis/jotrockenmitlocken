import 'package:flutter/material.dart';

import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/button_names.dart';

import 'package:jotrockenmitlockenrepo/Pages/Home/home.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JotrockenMitLockenHome extends Home {
  const JotrockenMitLockenHome(
      {super.key,
      required super.footer,
      required super.appAttributes,
      required super.controller,
      required super.scaffoldKey,
      required super.navigationShell,
      required super.handleChangedPageIndex});

  @override
  State<Home> createState() => JotrockenMitLockenHomeState();
}

class JotrockenMitLockenHomeState extends HomeState {
  @override
  ButtonNames getButtonNames() {
    return ButtonNames(
        brightness: AppLocalizations.of(context)!.toogleBrightness,
        color: AppLocalizations.of(context)!.selectSeedColor,
        language: AppLocalizations.of(context)!.switchLang);
  }
}
