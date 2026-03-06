import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';

class OpenSourceLicensesFooterConfig extends FooterPageConfig {
  @override
  String getHeading(BuildContext context) {
    return AppLocalizations.of(context)!.openSourceLicenses;
  }

  @override
  String getRoutingName() {
    return '/openSourceLicenses';
  }

  @override
  String getFilePathDe() {
    return '';
  }

  @override
  String getFilePathEn() {
    return '';
  }
}
