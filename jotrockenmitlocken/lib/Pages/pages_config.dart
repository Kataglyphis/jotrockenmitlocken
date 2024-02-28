import 'package:jotrockenmitlocken/Pages/pages_factory.dart';
import 'package:jotrockenmitlocken/Routing/stateful_branch_info_provider.dart';

class PagesConfig extends StatefulBranchInfoProvider {
  String routingName;
  PagesFactory pagesCreator;
  PagesConfig({required this.routingName, required this.pagesCreator});

  @override
  String getRoutingName() {
    return routingName;
  }

  @override
  PagesFactory getPagesFactory() {
    return pagesCreator;
  }
}
