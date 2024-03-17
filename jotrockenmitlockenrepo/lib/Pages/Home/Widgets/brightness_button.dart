import 'package:flutter/material.dart';

class BrightnessButton extends StatelessWidget {
  const BrightnessButton({
    super.key,
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
    required this.message,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow;
  final String message;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: message,
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}
