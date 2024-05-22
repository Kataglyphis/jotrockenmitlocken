import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BlockOverviewPage/block_entry.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BlockOverviewPage/block_entry_list.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';

class BlockOverviewPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const BlockOverviewPage(
      {super.key, required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => BlockOverviewPageState();
}

class BlockOverviewPageState extends State<BlockOverviewPage> {
  @override
  Widget build(BuildContext context) {
    List<BlockEntry> block_entries = widget.appAttributes.blockSettings
        .map(
          (config) => BlockEntry(
              title: (Localizations.localeOf(context) == Locale("de"))
                  ? config.shortDescriptionDE
                  : config.shortDescriptionEN,
              date: config.lastModified,
              comment: config.routingName),
        )
        .toList();
    return SinglePage(
      footer: widget.footer,
      showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
      children: [
        BlockEntryList(
          entryRedirectText: AppLocalizations.of(context)!.entryRedirectText,
          appAttributes: widget.appAttributes,
          title: AppLocalizations.of(context)!.blockEntryOverview,
          description:
              "${AppLocalizations.of(context)!.blockEntryOverviewDescription}\u{1F63A}",
          sortColumnIndex: 2,
          dataCategories: const ["Titel", "Date", "Comment"],
          data: block_entries,
        ),
      ],
    );
  }
}
