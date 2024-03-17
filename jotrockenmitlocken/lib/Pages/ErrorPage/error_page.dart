import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_widget.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class ErrorPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage(
        [
          const ErrorPageWidget(),
        ],
        JotrockenmitlockenFooter(
            footerPagesConfig:
                JotrockenmitLockenScreenConfigurations.getFooterPagesConfig()),
        appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
