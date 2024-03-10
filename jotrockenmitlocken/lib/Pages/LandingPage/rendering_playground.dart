import 'package:jotrockenmitlocken/Pages/LandingPage/landig_page_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RenderingPlayground extends StatefulWidget {
  const RenderingPlayground({
    super.key,
  });

  @override
  State<RenderingPlayground> createState() => _RenderingPlaygroundState();
}

class _RenderingPlaygroundState extends State<RenderingPlayground> {
  @override
  Widget build(BuildContext context) {
    return LandingPageEntry(
      label: AppLocalizations.of(context)!.renderingPlayground,
      routerPath: '/renderingBlog',
      headline: AppLocalizations.of(context)!.visitBlogEntry,
      imagePath: "assets/images/cat-computer.gif",
      githubRepo: 'GraphicsEngineVulkan',
    );
    // const colDivider = SizedBox(height: 10);
    // return ComponentGroupDecoration(
    //     label: AppLocalizations.of(context)!.renderingPlayground,
    //     children: <Widget>[
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           IconButton(
    //             iconSize: 50,
    //             icon: const FaIcon(FontAwesomeIcons.github),
    //             // color: Colors.black,
    //             onPressed: () {
    //               final Uri toLaunch = Uri(
    //                   scheme: 'https',
    //                   host: 'github.com',
    //                   path: 'Kataglyphis/GraphicsEngineVulkan');
    //               BrowserHelper.launchInBrowser(toLaunch);
    //             },
    //           ),
    //           Text(
    //               AppLocalizations.of(context)!.renderingPlaygroundDescription),
    //         ],
    //       ),
    //       colDivider,
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           FilledButton.tonal(
    //             onPressed: isDisabled
    //                 ? null
    //                 : () {
    //                     context.go('/renderingBlog');
    //                   },
    //             child: Text(AppLocalizations.of(context)!.visitBlogEntry),
    //           ),
    //         ],
    //       ),
    //       colDivider,
    //       applyBoxDecoration(
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(0),
    //             child: Image.asset("assets/images/cat-computer.gif"),
    //           ),
    //           borderRadius: 0,
    //           borderWidth: 5,
    //           color: Theme.of(context).colorScheme.primary),
    //       colDivider
    //     ]);
  }
}
