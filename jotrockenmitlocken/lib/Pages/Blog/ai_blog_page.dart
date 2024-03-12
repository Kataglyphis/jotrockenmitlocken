import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlocken/Widgets/appendix_table.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class AiBlogPage extends PagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    List<File> docs = [
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_english.pdf',
        additionalInfo: '~3.7MB English',
      ),
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_german.pdf',
        additionalInfo: '~3.7MB German',
      ),
      File(
          baseDir: 'assets/documents/',
          title: 'Bachelor_Thesis.pdf',
          additionalInfo: '~33MB German')
    ];
    return LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: '',
        filePathEn: 'assets/documents/blog/aiBlogPageEn.md',
        imageDirectory: 'assets/images/aiBlog',
        useLightMode: appFrameAttributes.useLightMode,
      ),
      AppendixTable(
        docs: docs,
      )
    ],
        ScreenConfigurations.getFooterPagesConfig(),
        appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }
}
