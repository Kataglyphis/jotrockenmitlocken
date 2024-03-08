import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/socialMedia/social_media_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Helper/browser_helper.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class Footer extends StatefulWidget {
  const Footer({
    super.key,
  });
  @override
  State<Footer> createState() => _Footer();
}

class _Footer extends State<Footer> {
  @override
  void initState() {
    super.initState();
  }

  Widget createTextButtons() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.start;
    if (currentWidth < mediumWidthBreakpoint) {
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
                    textStyle: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  context.go('/imprint');
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
                  context.go('/contact');
                },
                child: Text(
                  AppLocalizations.of(context)!.contact,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/privacyPolicy');
                },
                child: Text(
                  AppLocalizations.of(context)!.privacyPolicy,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  context.go('/cookieStatement');
                },
                child: Text(
                  AppLocalizations.of(context)!.cookieStatement,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: align,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    context.go('/declarationOnAccessibility');
                  },
                  child: Text(
                    AppLocalizations.of(context)!.declarationOnAccessibility,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ])
        ]);
  }

  Widget createTextButtonsForExternalLinks() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.center;
    if (currentWidth < mediumWidthBreakpoint) {
      align = MainAxisAlignment.center;
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.externalLinks,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https', host: 'johannes-heinle.de', path: '');
                  BrowserHelper.launchInBrowser(toLaunch);
                },
                style: Theme.of(context).textButtonTheme.style,
                child: const Text(
                  'johannes-heinle.de',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  final Uri toLaunch =
                      Uri(scheme: 'https', host: 'dom-wuest.de', path: '');
                  BrowserHelper.launchInBrowser(toLaunch);
                },
                child: const Text(
                  'dom-wuest.de',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
        ]);
  }

  Widget createSocialIconsAndLiabilityWidgets() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.start;
    if (currentWidth < mediumWidthBreakpoint) {
      align = MainAxisAlignment.center;
    }
    return Column(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SocialMediaWidgets(iconSize: 14),
        Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.disclaimer}\n${AppLocalizations.of(context)!.copyright}",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth < mediumWidthBreakpoint) {
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
          createTextButtonsForExternalLinks(),
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
                const SizedBox(
                  width: 30,
                ),
                createSocialIconsAndLiabilityWidgets(),
                const SizedBox(
                  width: 30,
                ),
                createTextButtonsForExternalLinks(),
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
