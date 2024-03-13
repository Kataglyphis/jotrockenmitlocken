import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class PrivacyPolicyPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage(
        [
          MarkdownFilePage(
            filePathDe: 'assets/documents/footer/privacyPolicyDe.md',
            filePathEn: 'assets/documents/footer/privacyPolicyEn.md',
            useLightMode: appFrameAttributes.useLightMode,
          )
        ],
        JotrockenmitlockenFooter(
            footerPagesConfig: ScreenConfigurations.getFooterPagesConfig()),
        appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
