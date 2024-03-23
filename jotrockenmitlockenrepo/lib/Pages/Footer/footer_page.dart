import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class FooterPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  final String filePathDe;
  final String filePathEn;
  FooterPage(
      {required this.appAttributes,
      required this.footer,
      required this.filePathDe,
      required this.filePathEn});
  @override
  State<StatefulWidget> createState() => FooterPageState();
}

class FooterPageState extends State<FooterPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
      children: [
        MarkdownFilePage(
          currentLocale: Localizations.localeOf(context),
          filePathDe: widget.filePathDe,
          filePathEn: widget.filePathEn,
          useLightMode: widget.appAttributes.useLightMode,
        )
      ],
      footer: widget.footer,
      showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
    );
  }
}
