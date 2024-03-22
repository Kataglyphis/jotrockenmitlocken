import 'package:jotrockenmitlocken/Pages/blog_page.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class AiBlogPageConfig extends BlogPageConfig {
  final AppAttributes appAttributes;

  AiBlogPageConfig(
      {required this.appAttributes,
      required super.landingPageEntryFactory,
      required super.landingPageAlignment});

  @override
  String getRoutingName() {
    return "/aiBlog";
  }
}
