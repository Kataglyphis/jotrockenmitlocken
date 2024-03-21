import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_widget.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class ErrorPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    return SinglePage(
        children: [
          const ErrorPageWidget(),
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
