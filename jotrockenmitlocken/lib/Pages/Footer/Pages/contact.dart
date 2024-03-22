import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class ContactPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  ContactPage({required this.appAttributes, required this.footer});
  @override
  State<StatefulWidget> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
      children: [
        MarkdownFilePage(
          filePathDe: 'assets/documents/footer/contactDe.md',
          filePathEn: 'assets/documents/footer/contactEn.md',
          useLightMode: widget.appAttributes.useLightMode,
        )
      ],
      footer: widget.footer,
      showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
    );
  }
}
