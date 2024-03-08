import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Layout/Widgets/Transitions/one_two_transition.dart';
import 'package:jotrockenmitlocken/Layout/Widgets/first_component_list.dart';
import 'package:jotrockenmitlocken/Layout/Widgets/second_component_list.dart';
import 'package:jotrockenmitlocken/Layout/vertical_scroll_page.dart';
import 'package:jotrockenmitlocken/Pages/Footer/footer.dart';

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
          if (!showMediumSizeLayout && !showLargeSizeLayout) ...[const Footer()]
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
    var colDivider = const SizedBox(height: 10);
    childWidgetsRightPage += [
      colDivider,
      if (!showMediumSizeLayout && !showLargeSizeLayout) ...[const Footer()]
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
