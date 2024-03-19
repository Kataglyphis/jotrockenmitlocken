import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/build_silvers.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/cache_height.dart';

class ScrollableList extends StatefulWidget {
  const ScrollableList({
    super.key,
    required this.childWidgets,
    this.padding = EdgeInsets.zero,
  });

  final List<Widget> childWidgets;
  final EdgeInsetsGeometry padding;

  @override
  State<ScrollableList> createState() => _ScrollableListState();
}

class _ScrollableListState extends State<ScrollableList> {
  @override
  Widget build(BuildContext context) {
    List<double?> heights = List.filled(widget.childWidgets.length, null);

    return FocusTraversalGroup(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverPadding(
            padding: widget.padding,
            sliver: SliverList(
              delegate: BuildSlivers(
                heights: heights,
                builder: (context, index) {
                  return CacheHeight(
                    heights: heights,
                    index: index,
                    child: widget.childWidgets[index],
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
