import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jotrockenmitlocken/Widgets/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/Widgets/component_group_decoration.dart';
import 'package:jotrockenmitlocken/Helper/browser_helper.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorPageWidget extends StatefulWidget {
  const ErrorPageWidget({
    super.key,
    required this.colorSelected,
  });
  final ColorSeed colorSelected;

  @override
  State<ErrorPageWidget> createState() => _ErrorPageWidget();
}

class _ErrorPageWidget extends State<ErrorPageWidget> {
  @override
  Widget build(BuildContext context) {
    const colDivider = SizedBox(height: 10);
    return ComponentGroupDecoration(label: 'Error 404', children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 50,
            icon: const FaIcon(FontAwesomeIcons.github),
            // color: Colors.black,
            onPressed: () {
              final Uri toLaunch = Uri(
                  scheme: 'https',
                  host: 'github.com',
                  path: 'Kataglyphis/MachineLearningAlgorithms');
              BrowserHelper.launchInBrowser(toLaunch);
            },
          ),
          Text(AppLocalizations.of(context)!.aiPlaygroundDescription)
        ],
      ),
      colDivider,
      applyBoxDecoration(
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset("assets/images/error404.gif"),
          ),
          const EdgeInsets.all(0),
          0,
          0,
          5,
          widget.colorSelected.color),
      colDivider
    ]);
  }
}
