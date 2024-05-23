import 'package:jotrockenmitlocken/blog_page_config.dart';
import 'package:jotrockenmitlocken/my_two_cents_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

mixin BlogDependentScreenConfigurations {
  List<StatefulBranchInfoProvider> getDataPagesConfig();
  List<BlogPageConfig> getBlogPagesConfig();
  List<MyTwoCentsConfig> getMediaCriticsPagesConfig();
}
