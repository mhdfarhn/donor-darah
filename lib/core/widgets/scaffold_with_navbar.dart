import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../constants/constants.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavbar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final routeLocation = GoRouterState.of(context).location;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: routeLocation != '/' && routeLocation != '/profile'
          ? null
          : BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              selectedItemColor: AppColor.red,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.house),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  label: '',
                ),
              ],
            ),
    );
  }
}
