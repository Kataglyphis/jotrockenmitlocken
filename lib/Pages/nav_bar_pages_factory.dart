import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';

abstract class NavBarPagesFactory {
  Widget createPage(AppFrameAttributes appFrameAttributes);
  NavigationDestination getNavigationDestination(BuildContext context);
}
