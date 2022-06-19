import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/DrawerItem.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/DrawerItems.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/NavigationDrawerChangeNotifier.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? Image.asset(
          "assets/icons/barbell.ico",
          width: 48,
        )
      : Row(
          children: [
            const SizedBox(width: 24),
            Image.asset(
              "assets/icons/barbell.ico",
              width: 48,
            ),
            const SizedBox(width: 24),
            const Text(
              'My blog',
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
          ],
        );

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;
    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
              width: width,
              height: size,
              child: Icon(icon, color: Colors.black)),
          onTap: () {
            final provider = Provider.of<NavigationDrawerChangeNotifier>(
                context,
                listen: false);
            provider.toogleIsCollapsed();
          },
        ),
      ),
    );
  }

  buildMenuItem(
      {required bool isCollapsed,
      required String text,
      required IconData icon,
      required Null Function() onClicked}) {
    final color = Colors.black;
    final leading = Icon(icon, color: color);

    return ListTile(
      leading: leading,
      title: Text(text, style: TextStyle(color: color, fontSize: 16)),
    );
  }

  buildList({required List<DrawerItem> items, required bool isCollapsed}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return buildMenuItem(
          isCollapsed: isCollapsed,
          text: item.title,
          icon: item.icon,
          onClicked: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationDrawerChangeNotifier>(context);
    final isCollapsed = provider.isCollapsed;
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                  child: buildHeader(isCollapsed)),
              buildList(items: itemsFirst, isCollapsed: isCollapsed),
              Spacer(),
              buildCollapseIcon(context, isCollapsed),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
