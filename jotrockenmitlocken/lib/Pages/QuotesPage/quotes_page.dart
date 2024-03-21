import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_list.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_pages_factory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';

class QuotesPage extends NavBarPagesFactory {
  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    return SinglePage(
        children: [
          QuotesList(
              title: AppLocalizations.of(context)!.quotations,
              description:
                  "${AppLocalizations.of(context)!.quotationsDescription}\u{1F63A}",
              dataFilePath: "assets/data/Zitate.csv"),
        ],
        footer: Footer(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
          footerConfig: appAttributes.footerConfig,
        ),
        showMediumSizeLayout: appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: appAttributes.showLargeSizeLayout);
  }

  @override
  NavigationDestination getNavigationDestination(BuildContext context) {
    return NavigationDestination(
      tooltip: '',
      icon: const Icon(Icons.record_voice_over_outlined),
      label: AppLocalizations.of(context)!.quotations,
      selectedIcon: const Icon(Icons.record_voice_over),
    );
  }
}
