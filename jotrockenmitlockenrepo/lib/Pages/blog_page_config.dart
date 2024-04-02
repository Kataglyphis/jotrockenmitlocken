import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

enum LandingPageAlignment { left, right }

abstract class BlogPageConfig extends StatefulBranchInfoProvider {
  LandingPageAlignment getAlignment();
  String getLabel(BuildContext context);
  String getImagePath();
  String getGithubRepoName();
  String getFilePath();
  String getImageDirectory();
  List<Map<String, String>> getDocsDesc();
}
