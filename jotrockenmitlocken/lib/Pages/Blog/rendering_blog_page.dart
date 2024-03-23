import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';

class RenderingBlogPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  RenderingBlogPage({required this.appAttributes, required this.footer});
  @override
  State<StatefulWidget> createState() => RenderingBlogPageState();
}

class RenderingBlogPageState extends State<RenderingBlogPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
        children: [
          MarkdownFilePage(
            currentLocale: Localizations.localeOf(context),
            filePathDe: '',
            filePathEn: 'assets/documents/blog/renderingBlogPageEn.md',
            imageDirectory: 'assets/images/aiBlog',
            useLightMode: widget.appAttributes.useLightMode,
          )
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
