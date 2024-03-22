import 'package:jotrockenmitlocken/Pages/blog_page_config.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class RenderingBlogPageConfig extends BlogPageConfig {
  final AppAttributes appAttributes;

  RenderingBlogPageConfig(
      {required this.appAttributes,
      required super.landingPageEntryFactory,
      required super.landingPageAlignment});

  @override
  String getRoutingName() {
    return "/rendering";
  }
}
