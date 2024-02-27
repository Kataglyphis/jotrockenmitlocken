import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_widget.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';

class ErrorPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    const colDivider = SizedBox(height: 10);
    return LayoutManager.createSinglePage([
      ErrorPageWidget(
        colorSelected: appFrameAttributes.colorSelected,
      ),
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}