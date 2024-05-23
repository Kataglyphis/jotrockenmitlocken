import 'package:jotrockenmitlocken/Pages/blog_dependent_screen_configurations.dart';
import 'package:jotrockenmitlocken/blog_page_config.dart';
import 'package:jotrockenmitlocken/my_two_cents_config.dart';

class BlogDependentAppAttributes {
  List<MyTwoCentsConfig> twoCentsConfigs;
  List<BlogPageConfig> blockSettings;

  BlogDependentScreenConfigurations blogDependentScreenConfigurations;

  BlogDependentAppAttributes(
      {required this.blogDependentScreenConfigurations,
      required this.twoCentsConfigs,
      required this.blockSettings});
}
