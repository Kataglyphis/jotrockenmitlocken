import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

abstract class FooterPageConfig extends StatefulBranchInfoProvider {
  String getHeading(BuildContext context);
  String getFilePathEn();
  String getFilePathDe();
}
