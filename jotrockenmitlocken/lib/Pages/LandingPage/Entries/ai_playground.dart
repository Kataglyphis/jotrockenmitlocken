import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landig_page_entry.dart';
import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landing_page_entry_factory.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AIPlayground extends LandingPageEntryFactory {
  AIPlayground({required super.routerPath});

  @override
  LandingPageEntry createLandingPageEntry(
      AppAttributes appAttributes, BuildContext context) {
    return LandingPageEntry(
      label: AppLocalizations.of(context)!.aiPlayground,
      routerPath: routerPath,
      headline: AppLocalizations.of(context)!.visitBlogEntry,
      imagePath: "assets/images/funny_programmer.gif",
      githubRepoName: 'MachineLearningAlgorithms',
      githubRepo: appAttributes.userSettings.getFullPathToGithubRepo(
        'MachineLearningAlgorithms',
      ),
      description: AppLocalizations.of(context)!.playgroundDescription,
    );
  }
}
