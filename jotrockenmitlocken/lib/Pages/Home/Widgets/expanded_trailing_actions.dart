import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:jotrockenmitlocken/Pages/Home/Widgets/expanded_color_seed_action.dart';

import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';

class ExpandedTrailingActions extends StatelessWidget {
  const ExpandedTrailingActions({
    super.key,
    required this.appAttributes,
  });

  final AppAttributes appAttributes;

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
                  value: appAttributes.useOtherLanguageMode,
                  onChanged: (value) {
                    appAttributes.handleLanguageChange();
                  })
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.brightness),
              Expanded(child: Container()),
              Switch(
                  value: appAttributes.useLightMode,
                  onChanged: (value) {
                    appAttributes.handleBrightnessChange(value);
                  })
            ],
          ),
          const Divider(),
          ExpandedColorSeedAction(
            handleColorSelect: appAttributes.handleColorSelect,
            colorSelected: appAttributes.colorSelected,
          ),
        ],
      ),
    );
    return screenHeight > 740
        ? trailingActionsBody
        : SingleChildScrollView(child: trailingActionsBody);
  }
}
