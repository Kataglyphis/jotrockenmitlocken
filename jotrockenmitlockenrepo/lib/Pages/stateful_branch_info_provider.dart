import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

abstract class StatefulBranchInfoProvider {
  String getRoutingName();
  PagesFactory getPagesFactory();
}
