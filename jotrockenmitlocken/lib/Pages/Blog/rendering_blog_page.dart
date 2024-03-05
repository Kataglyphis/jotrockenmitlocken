import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';

class RenderingBlogPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    return LayoutManager.createSinglePage([
      MarkdownFilePage(
        colorSelected: appFrameAttributes.colorSelected,
        filePathDe: '',
        filePathEn: 'assets/documents/blog/renderingBlogPageEn.md',
        imageDirectory: 'assets/images/aiBlog',
        useLightMode: appFrameAttributes.useLightMode,
      )
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
