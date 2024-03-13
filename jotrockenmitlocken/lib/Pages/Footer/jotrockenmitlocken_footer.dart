import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JotrockenmitlockenFooter extends Footer {
  JotrockenmitlockenFooter({required super.footerPagesConfig});

  @override
  JotrockenmitlockenFooterState createState() =>
      JotrockenmitlockenFooterState();
}

class JotrockenmitlockenFooterState extends FooterState {
  @override
  List<ExternalLinkConfig> getExternalLinks() {
    return [
      ExternalLinkConfig(host: 'johannes-heinle.de', path: ''),
      ExternalLinkConfig(host: 'dom-wuest.de', path: '')
    ];
  }

  @override
  String getExternalLinksTitle() {
    return AppLocalizations.of(context)!.externalLinks;
  }

  @override
  String getLiabilityText() {
    return "${AppLocalizations.of(context)!.disclaimer}\n${AppLocalizations.of(context)!.copyright}";
  }
}
