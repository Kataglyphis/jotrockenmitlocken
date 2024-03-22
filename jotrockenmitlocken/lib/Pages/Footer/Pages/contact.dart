import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';

class ContactPage extends StatefulWidget {
  final AppAttributes appAttributes;
  ContactPage({required this.appAttributes});
  @override
  State<StatefulWidget> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
      children: [
        MarkdownFilePage(
          filePathDe: 'assets/documents/footer/contactDe.md',
          filePathEn: 'assets/documents/footer/contactEn.md',
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
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
    );
  }
}
