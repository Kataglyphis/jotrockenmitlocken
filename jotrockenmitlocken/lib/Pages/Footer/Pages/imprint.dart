import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class ImprintPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  ImprintPage({required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => ImprintPageState();
}

class ImprintPageState extends State<ImprintPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
        children: [
          MarkdownFilePage(
            currentLocale: Localizations.localeOf(context),
            filePathDe: 'assets/documents/footer/imprintDe.md',
            filePathEn: 'assets/documents/footer/imprintEn.md',
            useLightMode: widget.appAttributes.useLightMode,
          )
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
