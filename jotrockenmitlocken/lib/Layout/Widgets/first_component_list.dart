import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Layout/Widgets/build_silvers.dart';
import 'package:jotrockenmitlocken/Layout/Widgets/cache_height.dart';

class FirstComponentList extends StatefulWidget {
  FirstComponentList({
    super.key,
    required this.showSecondList,
    required this.childWidgetsLeftPage,
    required this.childWidgetsRightPage,
  });

  final bool showSecondList;
  List<Widget> childWidgetsLeftPage;
  List<Widget> childWidgetsRightPage;

  @override
  State<FirstComponentList> createState() => _FirstComponentListState();
}

class _FirstComponentListState extends State<FirstComponentList> {
  @override
  Widget build(BuildContext context) {
    if (!widget.showSecondList) {
      widget.childWidgetsLeftPage =
          widget.childWidgetsLeftPage + widget.childWidgetsRightPage;
    }

    List<double?> heights =
        List.filled(widget.childWidgetsLeftPage.length, null);

    const smallSpacing = 10.0;

    // Fully traverse this list before moving on.
    return FocusTraversalGroup(
      child: CustomScrollView(
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
                    child: widget.childWidgetsLeftPage[index],
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
