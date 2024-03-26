import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/brightness_button.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/color_seed_button.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/language_button.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class TrailingActions extends StatefulWidget {
  final AppAttributes appAttributes;

  const TrailingActions({super.key, required this.appAttributes});
  @override
  State<StatefulWidget> createState() => TrailingActionsState();
}

class TrailingActionsState extends State<TrailingActions> {
  @override
  Widget build(BuildContext context) {
    var buttonNames = widget.appAttributes.homeConfig.getButtonNames(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (buttonNames.language != null &&
            widget.appAttributes.handleLanguageChange != null)
          Flexible(
            child: LanguageButton(
              handleLanguageChange: widget.appAttributes.handleLanguageChange!,
              showTooltipBelow: false,
              title: buttonNames.language!,
            ),
          ),
        if (buttonNames.brightness != null &&
            widget.appAttributes.handleBrightnessChange != null)
          Flexible(
            child: BrightnessButton(
              handleBrightnessChange:
                  widget.appAttributes.handleBrightnessChange!,
              showTooltipBelow: false,
              message: buttonNames.brightness!,
            ),
          ),
        if (buttonNames.color != null &&
            widget.appAttributes.handleColorSelect != null)
          Flexible(
            child: ColorSeedButton(
              handleColorSelect: widget.appAttributes.handleColorSelect!,
              colorSelected: widget.appAttributes.colorSelected,
              title: buttonNames.color!,
            ),
          ),
      ],
    );
  }
}
