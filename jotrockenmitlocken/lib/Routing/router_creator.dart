import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/Pages/Home/home.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/home.dart';
import 'package:jotrockenmitlockenrepo/Routing/router_creater.dart';

import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class JoTrockenMitLockenRoutesCreator extends RoutesCreator {
  @override
  Home getHome(
    Footer footer,
    AppAttributes appAttributes,
    AnimationController controller,
    StatefulNavigationShell navigationShell,
  ) {
    return JotrockenMitLockenHome(
      footer: footer,
      appAttributes: appAttributes,
      controller: controller,
      scaffoldKey: scaffoldKey,
      navigationShell: navigationShell,
      handleChangedPageIndex: (index) {
        currentPageIndex = index;
      },
    );
  }
}
