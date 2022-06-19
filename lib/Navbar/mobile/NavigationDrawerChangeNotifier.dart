import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class NavigationDrawerChangeNotifier extends ChangeNotifier {
  bool _isCollapsed = false;
  bool get isCollapsed => _isCollapsed;
  void toogleIsCollapsed() {
    _isCollapsed = !isCollapsed;
    notifyListeners();
  }
}
