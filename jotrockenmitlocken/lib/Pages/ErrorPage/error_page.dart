import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_widget.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class ErrorPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  ErrorPage({required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SinglePage(
        children: [
          const ErrorPageWidget(),
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
