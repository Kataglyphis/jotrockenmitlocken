import 'package:jotrockenmitlocken/Pages/LandingPage/landig_page_entry.dart';
import 'package:jotrockenmitlocken/Pages/pages_config.dart';

class BlogPagesConfig extends PagesConfig {
  LandingPageEntry landingPageEntry;
  LandingPageAlignment landingPageAlignment;
  BlogPagesConfig(
      {required super.routingName,
      required super.pagesCreator,
      required this.landingPageEntry,
      required this.landingPageAlignment});
}

enum LandingPageAlignment { left, right }
