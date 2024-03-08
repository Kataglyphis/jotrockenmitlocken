import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/document.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/document_table.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';

class AiBlogPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    List<Document> docs = [
      Document(
        'CV_Jonas_Heinle_english.pdf',
        '~3.7MB English',
      ),
      Document(
        'CV_Jonas_Heinle_german.pdf',
        '~3.7MB German',
      ),
      Document('Bachelor_Thesis.pdf', '~33MB German')
    ];
    return LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: '',
        filePathEn: 'assets/documents/blog/aiBlogPageEn.md',
        imageDirectory: 'assets/images/aiBlog',
        useLightMode: appFrameAttributes.useLightMode,
      ),
      DocumentTable(
        docs: docs,
      )
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
