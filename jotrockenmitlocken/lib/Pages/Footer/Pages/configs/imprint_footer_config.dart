import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImprintFooterConfig extends FooterPageConfig {
  @override
  String getHeading(BuildContext context) {
    return AppLocalizations.of(context)!.declarationOnAccessibility;
  }

  @override
  String getRoutingName() {
    return "/declarationOnAccessibility";
  }

  @override
  String getFilePathDe() {
    return 'assets/documents/footer/imprintDe.md';
  }

  @override
  String getFilePathEn() {
    return 'assets/documents/footer/imprintEn.md';
  }
}
