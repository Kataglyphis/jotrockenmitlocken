import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file_table.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class AiBlogPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  AiBlogPage({required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => AiBlogPageState();
}

class AiBlogPageState extends State<AiBlogPage> {
  @override
  Widget build(BuildContext context) {
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
          baseDir: 'assets/images/',
          title: 'WorleyNoiseTextures.zip',
          additionalInfo: 'Use it for you own projects.')
    ];
    return SinglePage(
        children: [
          MarkdownFilePage(
            currentLocale: Localizations.localeOf(context),
            filePathDe: '',
            filePathEn: 'assets/documents/blog/aiBlogPageEn.md',
            imageDirectory: 'assets/images/aiBlog',
            useLightMode: widget.appAttributes.useLightMode,
          ),
          FileTable(
            title: 'Appendix',
            docs: docs,
          )
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
