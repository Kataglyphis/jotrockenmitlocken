import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/socialMedia/social_media_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleFooter = const TextStyle(fontSize: 11);
    return SizedBox(
      height: 150.0,
      child: Expanded(
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
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold)),
                            onPressed: () {},
                            child: Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)!.imprint,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Kontakt",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Datenschutz",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Cookie Erklärung",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Erklärung zur Barrierefreiheit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ])
                    ]),
                SizedBox(
                  width: 30,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SocialMediaWidgets(iconSize: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Haftungsausschluss: Für die Inhalte externer Links übernehme ich keine Haftung.\n" +
                                "Copyright © 2024 Jonas Heinle. Alle Rechte vorbehalten.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ])
                  ],
                ),
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
      ),
    );
  }
}
