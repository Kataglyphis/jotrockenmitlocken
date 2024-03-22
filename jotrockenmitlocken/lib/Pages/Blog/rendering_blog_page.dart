import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/blog_page.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';

class RenderingBlogPage extends BlogPage {
  final AppAttributes appAttributes;

  RenderingBlogPage(
      {required super.landingPageEntryFactory,
      required super.landingPageAlignment,
      required this.appAttributes});
  @override
  State<StatefulWidget> createState() => RenderingBlogPageState();

  @override
  String getRoutingName() {
    // TODO: implement getRoutingName
    throw UnimplementedError();
  }
}

class RenderingBlogPageState extends State<RenderingBlogPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
        children: [
          MarkdownFilePage(
            filePathDe: '',
            filePathEn: 'assets/documents/blog/renderingBlogPageEn.md',
            imageDirectory: 'assets/images/aiBlog',
            useLightMode: widget.appAttributes.useLightMode,
          )
        ],
        footer: Footer(
          footerPages:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: widget.appAttributes.userSettings,
          footerConfig: widget.appAttributes.footerConfig,
        ),
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
