import 'constants.dart';

class NavigationState {
  int screenIndex = ScreenSelected.home.value;
  int screenIndexNonNavBar = NonNavBarScreenSelected.imprint.value;
  bool nonNavBarScreenSelected = false;
  NavigationState(
      {required this.screenIndex,
      required this.nonNavBarScreenSelected,
      required this.screenIndexNonNavBar});
}
