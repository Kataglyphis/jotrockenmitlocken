import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

abstract class NavBarPageConfig extends StatefulBranchInfoProvider {
  const NavBarPageConfig();
  NavigationDestination getNavigationDestination(BuildContext context);
}
