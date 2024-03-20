import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_pages_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyPagesConfig extends FooterPagesConfig {
  PrivacyPolicyPagesConfig(
      {required super.routingName, required super.pagesCreator});

  @override
  String getHeading(BuildContext context) {
    return AppLocalizations.of(context)!.privacyPolicy;
  }
}
