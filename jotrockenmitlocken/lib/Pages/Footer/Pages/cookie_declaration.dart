import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class CookieDeclarationPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  CookieDeclarationPage({required this.appAttributes, required this.footer});
  @override
  State<StatefulWidget> createState() => CookieDeclarationPageState();
}

class CookieDeclarationPageState extends State<CookieDeclarationPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
        children: [
          MarkdownFilePage(
            currentLocale: Localizations.localeOf(context),
            filePathDe: 'assets/documents/footer/cookieDeclarationDe.md',
            filePathEn: 'assets/documents/footer/cookieDeclarationEn.md',
            useLightMode: widget.appAttributes.useLightMode,
          )
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
