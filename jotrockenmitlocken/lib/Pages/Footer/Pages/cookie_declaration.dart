import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class CookieDeclarationPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage(
        [
          MarkdownFilePage(
            filePathDe: 'assets/documents/footer/cookieDeclarationDe.md',
            filePathEn: 'assets/documents/footer/cookieDeclarationEn.md',
            useLightMode: appFrameAttributes.useLightMode,
          )
        ],
        JotrockenmitlockenFooter(
            footerPagesConfig:
                JotrockenmitLockenScreenConfigurations.getFooterPagesConfig()),
        appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
