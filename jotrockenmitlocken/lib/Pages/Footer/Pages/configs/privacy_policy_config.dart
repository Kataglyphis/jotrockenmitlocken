import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyFooterConfig extends FooterPageConfig {
  @override
  String getHeading(BuildContext context) {
    return AppLocalizations.of(context)!.privacyPolicy;
  }

  @override
  String getRoutingName() {
    return "/privacyPolicy";
  }
}
