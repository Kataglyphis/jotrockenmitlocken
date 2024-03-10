import 'package:jotrockenmitlocken/Pages/LandingPage/landig_page_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AIPlayground extends StatefulWidget {
  const AIPlayground({
    super.key,
  });
  @override
  State<AIPlayground> createState() => _AIPlaygroundState();
}

class _AIPlaygroundState extends State<AIPlayground> {
  @override
  Widget build(BuildContext context) {
    return LandingPageEntry(
      label: AppLocalizations.of(context)!.aiPlayground,
      routerPath: '/aiBlog',
      headline: AppLocalizations.of(context)!.visitBlogEntry,
      imagePath: "assets/images/funny_programmer.gif",
      githubRepo: 'MachineLearningAlgorithms',
    );
  }
}
