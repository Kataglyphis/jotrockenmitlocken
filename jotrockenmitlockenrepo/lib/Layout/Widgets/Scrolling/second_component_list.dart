import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/build_silvers.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Scrolling/cache_height.dart';

class SecondComponentList extends StatefulWidget {
  const SecondComponentList({
    super.key,
    required this.childWidgets,
  });

  final List<Widget> childWidgets;

  @override
  State<SecondComponentList> createState() => _SecondComponentListState();
}

class _SecondComponentListState extends State<SecondComponentList> {
  @override
  Widget build(BuildContext context) {
    const smallSpacing = 10.0;
    List<double?> heights = List.filled(widget.childWidgets.length, null);

    // Fully traverse this list before moving on.
    // return ListView(
    //   children: widget.childWidgets,
    //   physics: BouncingScrollPhysics(),
    // );
    return FocusTraversalGroup(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverPadding(
            padding: const EdgeInsetsDirectional.only(end: smallSpacing),
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
