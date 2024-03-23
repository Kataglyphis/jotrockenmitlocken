import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/blog_page_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AiBlogPageConfig extends BlogPageConfig {
  @override
  String getRoutingName() {
    return "/aiBlog";
  }

  @override
  LandingPageAlignment getAlignment() {
    return LandingPageAlignment.left;
  }

  @override
  String getDescription(BuildContext context) {
    return AppLocalizations.of(context)!.playgroundDescription;
  }

  @override
  String getGithubRepoName() {
    return 'MachineLearningAlgorithms';
  }

  @override
  String getHeadline(BuildContext context) {
    return AppLocalizations.of(context)!.visitBlogEntry;
  }

  @override
  String getImagePath() {
    return "assets/images/funny_programmer.gif";
  }

  @override
  String getLabel(BuildContext context) {
    return AppLocalizations.of(context)!.aiPlayground;
  }
}
