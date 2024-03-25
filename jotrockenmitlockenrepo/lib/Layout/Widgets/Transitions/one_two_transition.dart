import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Animations/offset_animation.dart';
import 'package:jotrockenmitlockenrepo/Layout/Widgets/Animations/size_animation.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class OneTwoTransition extends StatefulWidget {
  const OneTwoTransition({
    super.key,
    required this.animation,
    required this.one,
    required this.two,
  });

  final Animation<double> animation;
  final Widget one;
  final Widget two;

  @override
  State<OneTwoTransition> createState() => _OneTwoTransitionState();
}

class _OneTwoTransitionState extends State<OneTwoTransition> {
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> widthAnimation;

  @override
  void initState() {
    super.initState();

    offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(OffsetAnimation(widget.animation));

    widthAnimation = Tween<double>(
      begin: 0,
      end: mediumWidthBreakpoint,
    ).animate(SizeAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: mediumWidthBreakpoint.toInt(),
          child: widget.one,
        ),
        if (MediaQuery.of(context).size.width > mediumWidthBreakpoint) ...[
          Flexible(
            // widthAnimation.value.toInt() > 0
            flex: widthAnimation.value.toInt(),
            child: widget.two,
            // FractionalTranslation(
            //   translation: offsetAnimation.value,
            //   child: widget.two,
            // ),
          )
        ],
      ],
    );
  }
}
