import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/button_names.dart';

import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/expanded_color_seed_action.dart';

import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class ExpandedTrailingActions extends StatelessWidget {
  const ExpandedTrailingActions({
    super.key,
    required this.appAttributes,
    required this.buttonNames,
  });

  final AppAttributes appAttributes;
  final ButtonNames buttonNames;

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
          if (buttonNames.language != null &&
              appAttributes.handleLanguageChange != null)
            if (appAttributes.useOtherLanguageMode != null)
              Row(
                children: [
                  Text(buttonNames.language!),
                  Expanded(child: Container()),
                  Switch(
                      value: appAttributes.useOtherLanguageMode!,
                      onChanged: (value) {
                        appAttributes.handleLanguageChange!();
                      })
                ],
              ),
          const Divider(),
          if (buttonNames.brightness != null)
            Row(
              children: [
                Text(buttonNames.brightness!),
                Expanded(child: Container()),
                if (appAttributes.handleBrightnessChange != null)
                  Switch(
                      value: appAttributes.useLightMode,
                      onChanged: (value) {
                        appAttributes.handleBrightnessChange!(value);
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
