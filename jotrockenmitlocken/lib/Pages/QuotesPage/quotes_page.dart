import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_list.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_pages_factory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotesPage extends NavBarPagesFactory {
  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    return LayoutManager.createSinglePage(
        [
          QuotesList(
              title: AppLocalizations.of(context)!.quotations,
              description:
                  "${AppLocalizations.of(context)!.quotationsDescription}\u{1F63A}",
              dataFilePath: "assets/data/Zitate.csv"),
        ],
        JotrockenmitlockenFooter(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
        ),
        appAttributes.showMediumSizeLayout,
        appAttributes.showLargeSizeLayout);
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
