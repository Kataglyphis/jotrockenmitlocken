import 'package:jotrockenmitlocken/Pages/blog_page_config.dart';

class AiBlogPageConfig extends BlogPageConfig {
  AiBlogPageConfig(
      {required super.landingPageEntryFactory,
      required super.landingPageAlignment});

  @override
  String getRoutingName() {
    return "/aiBlog";
  }
}
