import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Media/markdown_page.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';

class PrivacyPolicyPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: 'assets/documents/footer/privacyPolicyDe.md',
        filePathEn: 'assets/documents/footer/privacyPolicyEn.md',
      )
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}