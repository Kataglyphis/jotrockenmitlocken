import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Footer/footer_pages_creator.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Transitions/one_two_transition.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/first_component_list.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/second_component_list.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/vertical_scroll_page.dart';
import 'package:jotrockenmitlockenrepo/Footer/footer.dart';

class LayoutManager {
  static Widget createSinglePage(
    List<Widget> children,
    List<FooterPagesConfig> footerPagesConfig,
    bool showMediumSizeLayout,
    bool showLargeSizeLayout,
  ) {
    const colDivider = SizedBox(height: 10);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalScrollPage(childWidgets: [
          colDivider,
          ...children,
          colDivider,
          if (!showMediumSizeLayout && !showLargeSizeLayout) ...[
            Footer(
              footerPagesConfig: footerPagesConfig,
            )
          ]
        ]),
      ],
    );
  }

  static Widget createOneTwoTransisionWidget(
      List<Widget> childWidgetsLeftPage,
      List<Widget> childWidgetsRightPage,
      List<FooterPagesConfig> footerPagesConfig,
      bool showMediumSizeLayout,
      bool showLargeSizeLayout,
      CurvedAnimation railAnimation) {
    var colDivider = const SizedBox(height: 10);
    childWidgetsRightPage += [
      colDivider,
      if (!showMediumSizeLayout && !showLargeSizeLayout) ...[
        Footer(
          footerPagesConfig: footerPagesConfig,
        )
      ]
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
