import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, 
    required this.handleLanguageChange,
    this.showTooltipBelow = true,
  });

  final Function handleLanguageChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: AppLocalizations.of(context)!.toogleLanguage,
      child: IconButton(
        icon: const Icon(Icons.translate),
        onPressed: () => handleLanguageChange(),
      ),
    );
  }
}
