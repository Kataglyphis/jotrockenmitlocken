import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/build_silvers.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/cache_height.dart';

class FirstComponentList extends StatefulWidget {
  const FirstComponentList({
    super.key,
    required this.showSecondList,
    required this.childWidgetsLeftPage,
    required this.childWidgetsRightPage,
  });

  final bool showSecondList;
  final List<Widget> childWidgetsLeftPage;
  final List<Widget> childWidgetsRightPage;

  @override
  State<FirstComponentList> createState() => _FirstComponentListState();
}

class _FirstComponentListState extends State<FirstComponentList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> resultingChildWidgetsLeftPage = widget.childWidgetsLeftPage;
    if (!widget.showSecondList) {
      resultingChildWidgetsLeftPage =
          widget.childWidgetsLeftPage + widget.childWidgetsRightPage;
    }

    List<double?> heights =
        List.filled(resultingChildWidgetsLeftPage.length, null);

    const smallSpacing = 10.0;

    // Fully traverse this list before moving on.
    // return ListView(
    //   children: resultingChildWidgetsLeftPage,
    //   physics: BouncingScrollPhysics(),
    // );
    return FocusTraversalGroup(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverPadding(
            padding: widget.showSecondList
                ? const EdgeInsetsDirectional.only(end: smallSpacing)
                : EdgeInsets.zero,
            sliver: SliverList(
              delegate: BuildSlivers(
                heights: heights,
                builder: (context, index) {
                  return CacheHeight(
                    heights: heights,
                    index: index,
                    child: resultingChildWidgetsLeftPage[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
