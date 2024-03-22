import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landing_page_entry_factory.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

abstract class BlogPageConfig extends StatefulBranchInfoProvider {
  LandingPageEntryFactory landingPageEntryFactory;
  LandingPageAlignment landingPageAlignment;
  BlogPageConfig({
    required this.landingPageEntryFactory,
    required this.landingPageAlignment,
  });
}

enum LandingPageAlignment { left, right }
