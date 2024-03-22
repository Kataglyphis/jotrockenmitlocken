import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class ImprintPage extends StatefulWidget {
  final AppAttributes appAttributes;
  ImprintPage({required this.appAttributes});

  @override
  State<StatefulWidget> createState() => ImprintPageState();
}

class ImprintPageState extends State<ImprintPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
        children: [
          MarkdownFilePage(
            filePathDe: 'assets/documents/footer/imprintDe.md',
            filePathEn: 'assets/documents/footer/imprintEn.md',
            useLightMode: widget.appAttributes.useLightMode,
          )
        ],
        footer: Footer(
          footerPagesConfigs:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: widget.appAttributes.userSettings,
          footerConfig: widget.appAttributes.footerConfig,
        ),
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
