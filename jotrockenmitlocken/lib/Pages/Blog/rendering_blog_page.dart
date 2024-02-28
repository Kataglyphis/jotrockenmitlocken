import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Media/markdown_page.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';

class RenderingBlogPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: '',
        filePathEn: 'assets/documents/blog/renderingBlogPageEn.md',
      )
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
