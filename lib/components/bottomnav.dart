import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../states/navigationstate.dart';
import '../themes/colors.dart';
import '../utils/enums.dart';
import 'drawer.dart';

class BoottomNavBar extends HookConsumerWidget {
  final Widget childElement;

  const BoottomNavBar({super.key, required this.childElement});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final navbarStateW = ref.watch(navbarState);
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrwer(scaffoldkey: scaffoldKey),
      appBar: AppBar(
        backgroundColor: const Color(0xff212037),
        leading: InkWell(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.sort,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Profile",
          textScaleFactor: 1,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              navbarStateW.changePage(BottomNavigation.none);
              context.go("/notification");
            },
            icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              navbarStateW.changePage(BottomNavigation.none);
              context.go("/settings");
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff212037),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: childElement,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: const BoxDecoration(
              color: Color(0xff212037),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavTab(
                  isActive: navbarStateW.bottomNav == BottomNavigation.home,
                  icon: Icons.home,
                  color: indigoColor,
                  function: () {
                    navbarStateW.changePage(BottomNavigation.home);
                    context.go("/home");
                  },
                ),
                BottomNavTab(
                  isActive:
                      navbarStateW.bottomNav == BottomNavigation.watchlist,
                  icon: Icons.graphic_eq,
                  color: cyanColor,
                  function: () {
                    navbarStateW.changePage(BottomNavigation.watchlist);
                    context.go("/watchlist");
                  },
                ),
                BottomNavTab(
                  isActive:
                      navbarStateW.bottomNav == BottomNavigation.protfolio,
                  icon: Icons.bolt,
                  color: yellowColor,
                  function: () {
                    navbarStateW.changePage(BottomNavigation.protfolio);
                    context.go("/protfolio");
                  },
                ),
                BottomNavTab(
                  isActive: navbarStateW.bottomNav == BottomNavigation.orders,
                  icon: Icons.notes,
                  color: roseColor,
                  function: () {
                    navbarStateW.changePage(BottomNavigation.orders);
                    context.go("/orders");
                  },
                ),
                BottomNavTab(
                  isActive: navbarStateW.bottomNav == BottomNavigation.account,
                  icon: Icons.person,
                  color: emeraldColor,
                  function: () {
                    navbarStateW.changePage(BottomNavigation.account);
                    context.go("/account");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavTab extends HookConsumerWidget {
  final bool isActive;
  final Color color;
  final IconData icon;
  final Function function;

  const BottomNavTab({
    super.key,
    required this.icon,
    required this.color,
    required this.isActive,
    required this.function,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => function(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: isActive ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
