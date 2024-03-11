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
  }
}
