import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Transitions/one_two_transition.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/first_component_list.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/second_component_list.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';

class LayoutManager {
  static Widget createSinglePage(
    List<Widget> children,
    Footer footer,
    bool showMediumSizeLayout,
    bool showLargeSizeLayout,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FirstComponentList(
            showSecondList: false,
            childWidgetsLeftPage: [...children] +
                [
                  colDivider,
                  if (!showMediumSizeLayout && !showLargeSizeLayout) ...[footer]
                ],
            childWidgetsRightPage: const [],
          ),
        ),
      ],
    );
  }

  static Widget createOneTwoTransisionWidget(
      List<Widget> childWidgetsLeftPage,
      List<Widget> childWidgetsRightPage,
      Footer footer,
      bool showMediumSizeLayout,
      bool showLargeSizeLayout,
      CurvedAnimation railAnimation) {
    childWidgetsRightPage += [
      colDivider,
      if (!showMediumSizeLayout && !showLargeSizeLayout) ...[footer]
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
