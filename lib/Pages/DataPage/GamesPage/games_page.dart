import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/GamesPage/games_list.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';

class GamesPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const GamesPage(
      {super.key, required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => GamesPageState();
}

class GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
      footer: widget.footer,
      showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
      children: [
        GamesList(
            entryRedirectText: AppLocalizations.of(context)!.entryRedirectText,
            appAttributes: widget.appAttributes,
            title: AppLocalizations.of(context)!.games,
            description:
                "${AppLocalizations.of(context)!.gamesDescription}\u{1F63A}",
            dataFilePath: "assets/data/Spiele.csv"),
      ],
    );
  }
}
