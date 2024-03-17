import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class DeclarationOnAccessibilityPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage(
        [
          MarkdownFilePage(
            filePathDe:
                'assets/documents/footer/declarationOnAccessibilityDe.md',
            filePathEn:
                'assets/documents/footer/declarationOnAccessibilityEn.md',
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
