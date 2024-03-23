import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Layout/adaptive_grid.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:go_router/go_router.dart';

class FooterPagesTextButtons extends StatefulWidget {
  const FooterPagesTextButtons({super.key, required this.footerPagesConfig});
  final List<FooterPageConfig> footerPagesConfig;
  @override
  State<StatefulWidget> createState() => FooterPagesTextButtonsState();
}

class FooterPagesTextButtonsState extends State<FooterPagesTextButtons> {
  final int maxNumFooterPageTextButtonsPerRow = 3;
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.start;
    if (currentWidth < mediumWidthBreakpoint) {
      align = MainAxisAlignment.center;
    }
    List<TextButton> footerPagesButtons = widget.footerPagesConfig
        .map((footerPageConfig) => (TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                context.go(footerPageConfig.getRoutingName());
              },
              child: Text(
                textAlign: TextAlign.center,
                footerPageConfig.getHeading(context),
              ),
            )))
        .toList();

    return AdaptiveGrid(
      maxgridWidgetsPerRow: maxNumFooterPageTextButtonsPerRow,
      gridWidgets: footerPagesButtons,
      rowAlignment: align,
    );
  }
}
