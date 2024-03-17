import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.handleLanguageChange,
    this.showTooltipBelow = true,
    required this.title,
  });

  final Function handleLanguageChange;
  final bool showTooltipBelow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: title,
      child: IconButton(
        icon: const Icon(Icons.translate),
        onPressed: () => handleLanguageChange(),
      ),
    );
  }
}
