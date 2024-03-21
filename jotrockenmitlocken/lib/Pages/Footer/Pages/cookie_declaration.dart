import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class CookieDeclarationPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    return SinglePage(
        children: [
          MarkdownFilePage(
            filePathDe: 'assets/documents/footer/cookieDeclarationDe.md',
            filePathEn: 'assets/documents/footer/cookieDeclarationEn.md',
            useLightMode: appAttributes.useLightMode,
          )
        ],
        footer: Footer(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
          footerConfig: appAttributes.footerConfig,
        ),
        showMediumSizeLayout: appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: appAttributes.showLargeSizeLayout);
  }
}
