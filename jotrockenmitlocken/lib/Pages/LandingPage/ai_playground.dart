import 'package:jotrockenmitlocken/Pages/LandingPage/landig_page_entry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AIPlayground extends LandingPageEntry {
  const AIPlayground({
    super.key,
  });
  @override
  AIPlaygroundState createState() => AIPlaygroundState();
}

class AIPlaygroundState extends LandingPageEntryState {
  @override
  String getGithubRepo() {
    return 'MachineLearningAlgorithms';
  }

  @override
  String getHeadline() {
    return AppLocalizations.of(context)!.visitBlogEntry;
  }

  @override
  String getImagePath() {
    return "assets/images/funny_programmer.gif";
  }

  @override
  String getLabel() {
    return AppLocalizations.of(context)!.aiPlayground;
  }

  @override
  String getRouterPath() {
    return '/aiBlog';
  }
}
