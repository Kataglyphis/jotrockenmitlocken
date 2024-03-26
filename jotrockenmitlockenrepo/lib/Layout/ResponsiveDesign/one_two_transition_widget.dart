import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/scrollable_list.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Transitions/one_two_transition.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/first_component_list.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';

class OneTwoTransitionPage extends StatefulWidget {
  final List<Widget> childWidgetsLeftPage;
  final List<Widget> childWidgetsRightPage;
  final Footer footer;
  final bool showMediumSizeLayout;
  final bool showLargeSizeLayout;
  final CurvedAnimation railAnimation;

  const OneTwoTransitionPage(
      {super.key,
      required this.childWidgetsLeftPage,
      required this.childWidgetsRightPage,
      required this.footer,
      required this.showMediumSizeLayout,
      required this.showLargeSizeLayout,
      required this.railAnimation});
  @override
  State<StatefulWidget> createState() => OneTwoTransitionPageState();
}

class OneTwoTransitionPageState extends State<OneTwoTransitionPage> {
  @override
  Widget build(BuildContext context) {
    return OneTwoTransition(
      animation: widget.railAnimation,
      one: FirstComponentList(
        showSecondList:
            widget.showMediumSizeLayout || widget.showLargeSizeLayout,
        childWidgetsLeftPage: widget.childWidgetsLeftPage,
        childWidgetsRightPage:
            (widget.showMediumSizeLayout || widget.showLargeSizeLayout)
                ? widget.childWidgetsRightPage
                : widget.childWidgetsRightPage + [widget.footer],
      ),
      two: ListView(
        //ScrollableList(childWidgets:
        padding: const EdgeInsetsDirectional.only(end: 10.0),
        children: widget.childWidgetsRightPage,
      ),
    );
  }
}
