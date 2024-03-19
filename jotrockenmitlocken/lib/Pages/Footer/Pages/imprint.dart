import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class ImprintPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    return LayoutManager.createSinglePage(
        [
          MarkdownFilePage(
            filePathDe: 'assets/documents/footer/imprintDe.md',
            filePathEn: 'assets/documents/footer/imprintEn.md',
            useLightMode: appAttributes.useLightMode,
          )
        ],
        JotrockenmitlockenFooter(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
        ),
        appAttributes.showMediumSizeLayout,
        appAttributes.showLargeSizeLayout);
  }
}
