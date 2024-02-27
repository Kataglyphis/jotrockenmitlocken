import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Widgets/Media/quotes_list.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/nav_bar_pages_factory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotesPage extends NavBarPagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage([
      QuotesList(
        colorSelected: appFrameAttributes.colorSelected,
      ),
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
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
