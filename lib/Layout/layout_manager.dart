import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Blog/blog.dart';
import 'package:jotrockenmitlocken/Layout/vertical_scroll_page.dart';
import 'package:jotrockenmitlocken/footer.dart';
import 'package:jotrockenmitlocken/home.dart';

class LayoutManager {
  static Widget createSinglePage(List<Widget> children,
      bool showMediumSizeLayout, bool showLargeSizeLayout) {
    const colDivider = SizedBox(height: 10);
    return Row(
      children: [
        VerticalScrollPage(childWidgets: [
          colDivider,
          ...children,
          colDivider,
          if (!showMediumSizeLayout && !showLargeSizeLayout) ...[Footer()]
        ]),
      ],
    );
  }

  static Widget createOneTwoTransisionWidget(
      List<Widget> childWidgetsLeftPage,
      List<Widget> childWidgetsRightPage,
      bool showMediumSizeLayout,
      bool showLargeSizeLayout,
      CurvedAnimation railAnimation) {
    childWidgetsRightPage += [
      colDivider,
      if (!showMediumSizeLayout && !showLargeSizeLayout) ...[Footer()]
    ];
    return Row(
      children: [
        Expanded(
          child: OneTwoTransition(
            animation: railAnimation,
            one: FirstComponentList(
              showSecondList: showMediumSizeLayout || showLargeSizeLayout,
              childWidgetsLeftPage: childWidgetsLeftPage,
              childWidgetsRightPage: childWidgetsRightPage,
            ),
            two: SecondComponentList(
              childWidgets: childWidgetsRightPage,
            ),
          ),
        ),
      ],
    );
  }
}
