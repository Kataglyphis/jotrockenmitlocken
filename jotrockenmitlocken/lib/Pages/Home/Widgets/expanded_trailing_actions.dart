import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:jotrockenmitlocken/Pages/Home/Widgets/expanded_color_seed_action.dart';

import 'package:jotrockenmitlockenrepo/constants.dart';

class ExpandedTrailingActions extends StatelessWidget {
  const ExpandedTrailingActions({super.key, 
    required this.useLightMode,
    required this.useOtherLanguageMode,
    required this.handleBrightnessChange,
    required this.handleLanguageChange,
    required this.handleColorSelect,
    required this.colorSelected,
  });

  final void Function(bool) handleBrightnessChange;
  final void Function() handleLanguageChange;
  final void Function(int) handleColorSelect;

  final bool useLightMode;
  final bool useOtherLanguageMode;
  final ColorSeed colorSelected;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final trailingActionsBody = Container(
      constraints: const BoxConstraints.tightFor(width: 250),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(AppLocalizations.of(context)!.switchLang),
              Expanded(child: Container()),
              Switch(
                  value: useOtherLanguageMode,
                  onChanged: (value) {
                    handleLanguageChange();
                  })
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.brightness),
              Expanded(child: Container()),
              Switch(
                  value: useLightMode,
                  onChanged: (value) {
                    handleBrightnessChange(value);
                  })
            ],
          ),
          const Divider(),
          ExpandedColorSeedAction(
            handleColorSelect: handleColorSelect,
            colorSelected: colorSelected,
          ),
        ],
      ),
    );
    return screenHeight > 740
        ? trailingActionsBody
        : SingleChildScrollView(child: trailingActionsBody);
  }
}
