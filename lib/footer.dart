import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/socialMedia/social_media_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/constants.dart';

class Footer extends StatefulWidget {
  const Footer({super.key, this.onSelectItem, required this.selectedIndex});
  final void Function(int)? onSelectItem;
  final int selectedIndex;
  @override
  State<Footer> createState() => _Footer();
}

class _Footer extends State<Footer> {
  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  Widget createTextButtons() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.start;
    if (currentWidth < narrowScreenWidthThreshold) {
      align = MainAxisAlignment.center;
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (widget.onSelectItem != null) {
                    widget.onSelectItem!(NonNavBarScreenSelected.imprint.value);
                  }
                },
                child: Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)!.imprint,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.onSelectItem != null) {
                    widget.onSelectItem!(NonNavBarScreenSelected.contact.value);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.contact,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.onSelectItem != null) {
                    widget.onSelectItem!(
                        NonNavBarScreenSelected.privacyPolicy.value);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.privacyPolicy,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.cookieStatement,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: align,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.declarationOnAccessibility,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ])
        ]);
  }

  Widget createSocialIconsAndLiabilityWidgets() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.start;
    if (currentWidth < narrowScreenWidthThreshold) {
      align = MainAxisAlignment.center;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SocialMediaWidgets(iconSize: 20),
        Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.disclaimer +
                    "\n" +
                    AppLocalizations.of(context)!.copyright,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    TextStyle textStyleFooter = const TextStyle(fontSize: 11);
    if (currentWidth < narrowScreenWidthThreshold) {
      return Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          createTextButtons(),
          const SizedBox(
            height: 30,
          ),
          createSocialIconsAndLiabilityWidgets(),
          const SizedBox(
            height: 30,
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 150.0,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),

            // const Expanded(
            //     child: Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [],
            // )),
            // const Expanded(
            //     child: Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [],
            // )),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                ),
                createTextButtons(),
                createSocialIconsAndLiabilityWidgets(),
              ],
            ),
            // const Expanded(
            //     child: Column(
            //   children: [],
            // )),

            // const Expanded(
            //     child: Column(
            //   children: [],
            // )),
          ],
        ),
      );
    }
  }
}
