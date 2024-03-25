import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlockenrepo/Pages/blog_page_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RenderingBlogPageConfig extends BlogPageConfig {
  @override
  String getRoutingName() {
    return "/rendering";
  }

  @override
  LandingPageAlignment getAlignment() {
    return LandingPageAlignment.right;
  }

  @override
  String getDescription(BuildContext context) {
    return AppLocalizations.of(context)!.playgroundDescription;
  }

  @override
  String getGithubRepoName() {
    return 'GraphicsEngineVulkan';
  }

  @override
  String getHeadline(BuildContext context) {
    return AppLocalizations.of(context)!.visitBlogEntry;
  }

  @override
  String getImagePath() {
    return "assets/images/cat-computer.gif";
  }

  @override
  String getLabel(BuildContext context) {
    return AppLocalizations.of(context)!.renderingPlayground;
  }

  @override
  List<Map<String, String>> getDocsDesc() {
    return [
      {
        'baseDir': 'assets/documents/',
        'title': 'CV_Jonas_Heinle_english.pdf',
        'additionalInfo': '~3.7MB English',
      },
      {
        'baseDir': 'assets/documents/',
        'title': 'CV_Jonas_Heinle_german.pdf',
        'additionalInfo': '~3.7MB German',
      },
      {
        'baseDir': 'assets/images/',
        'title': 'WorleyNoiseTextures.zip',
        'additionalInfo': 'Use it for you own projects.',
      },
    ];
  }

  @override
  String getFilePathDe() {
    return '';
  }

  @override
  String getFilePathEn() {
    return 'assets/documents/blog/renderingBlogPageEn.md';
  }

  @override
  String getImageDirectory() {
    return 'assets/images/aiBlog';
  }
}
