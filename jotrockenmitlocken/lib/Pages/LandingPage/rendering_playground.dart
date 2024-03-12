import 'package:jotrockenmitlocken/Pages/LandingPage/landig_page_entry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RenderingPlayground extends LandingPageEntry {
  const RenderingPlayground({
    super.key,
  });
  @override
  RenderingPlaygroundState createState() => RenderingPlaygroundState();
}

class RenderingPlaygroundState extends LandingPageEntryState {
  @override
  String getGithubRepo() {
    return 'GraphicsEngineVulkan';
  }

  @override
  String getHeadline() {
    return AppLocalizations.of(context)!.visitBlogEntry;
  }

  @override
  String getImagePath() {
    return "assets/images/cat-computer.gif";
  }

  @override
  String getLabel() {
    return AppLocalizations.of(context)!.renderingPlayground;
  }

  @override
  String getRouterPath() {
    return '/renderingBlog';
  }
}
