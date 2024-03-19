import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landing_page_entry_factory.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_config.dart';

class BlogPagesConfig extends PagesConfig {
  LandingPageEntryFactory landingPageEntryFactory;
  LandingPageAlignment landingPageAlignment;
  BlogPagesConfig({
    required super.routingName,
    required super.pagesCreator,
    required this.landingPageEntryFactory,
    required this.landingPageAlignment,
  });
}

enum LandingPageAlignment { left, right }
