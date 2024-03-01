import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';

class DeclarationOnAccessibilityPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage([
      MarkdownFilePage(
        colorSelected: appFrameAttributes.colorSelected,
        filePathDe: 'assets/documents/footer/declarationOnAccessibilityDe.md',
        filePathEn: 'assets/documents/footer/declarationOnAccessibilityEn.md',
      )
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
