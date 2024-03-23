import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_list.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';

class QuotesPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  QuotesPage({required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => QuotesPageState();
}

class QuotesPageState extends State<QuotesPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
        children: [
          QuotesList(
              title: AppLocalizations.of(context)!.quotations,
              description:
                  "${AppLocalizations.of(context)!.quotationsDescription}\u{1F63A}",
              dataFilePath: "assets/data/Zitate.csv"),
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
