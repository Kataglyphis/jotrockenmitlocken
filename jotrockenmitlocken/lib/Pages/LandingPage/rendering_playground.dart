import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/Widgets/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/Widgets/component_group_decoration.dart';
import 'package:jotrockenmitlocken/Helper/browser_helper.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RenderingPlayground extends StatefulWidget {
  const RenderingPlayground({
    super.key,
    required this.colorSelected,
  });
  final ColorSeed colorSelected;

  @override
  State<RenderingPlayground> createState() => _RenderingPlaygroundState();
}

class _RenderingPlaygroundState extends State<RenderingPlayground> {
  bool isDisabled = false;
  @override
  Widget build(BuildContext context) {
    const colDivider = SizedBox(height: 10);
    return ComponentGroupDecoration(
        label: AppLocalizations.of(context)!.renderingPlayground,
        children: <Widget>[
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
                      path: 'Kataglyphis/GraphicsEngineVulkan');
                  BrowserHelper.launchInBrowser(toLaunch);
                },
              ),
              Text(
                  AppLocalizations.of(context)!.renderingPlaygroundDescription),
            ],
          ),
          colDivider,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.tonal(
                onPressed: isDisabled
                    ? null
                    : () {
                        context.go('/renderingblog');
                      },
                child: Text(AppLocalizations.of(context)!.visitBlogEntry),
              ),
            ],
          ),
          colDivider,
          applyBoxDecoration(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset("assets/images/cat-computer.gif"),
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
