// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:trading_app/views/chat/contact_list.dart';
import 'package:trading_app/views/mains/home.dart';
import 'package:trading_app/views/mains/order/top_bar.dart';
import 'package:trading_app/views/mains/watchlist.dart';
import 'package:trading_app/views/profile/profile.dart';

class BoottomNavBar extends HookConsumerWidget {
  const BoottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Image.asset(
            'assets/icons/home.png',
            color: const Color.fromARGB(255, 50, 27, 197),
            scale: 0.95,
          ),
          title: 'rachu',
          inactiveIcon: Image.asset('assets/icons/home.png', scale: 1.1),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/icons/watchlist.png',
              scale: 0.85, color: const Color.fromARGB(255, 60, 40, 188)),
          inactiveIcon: Image.asset('assets/icons/watchlist.png'),
          title: ("Watchlist"),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/icons/order_list.png',
              scale: 0.85, color: const Color.fromARGB(255, 60, 40, 188)),
          inactiveIcon: Image.asset('assets/icons/order_list.png', scale: 1),
          title: ("Watchlist"),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/icons/chat.png',
              scale: 0.9, color: const Color.fromARGB(255, 60, 40, 188)),
          inactiveIcon: Image.asset('assets/icons/chat.png', scale: 1.05),
          title: ("Watchlist"),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/icons/account.png',
              scale: 0.85, color: const Color.fromARGB(255, 60, 40, 188)),
          inactiveIcon: Image.asset(
            'assets/icons/account.png',
            scale: 1,
          ),
          title: ("Watchlist"),
        ),
      ];
    }

    List<Widget> buildScreens() {
      return [
        const HomePage(),
        const WishListPage(),
        const OrderPage(),
        const ChatList(),
        const AccountPage(),
      ];
    }

    Color navActiveColor = Colors.indigo;
    Color navInActiveColor = Colors.grey;

    // void pageChange(int value) {
    //   switch (value) {
    //     case 0:
    //       context.go("/home");
    //       break;
    //     case 1:
    //       context.go("/watchlist");
    //       break;
    //     case 2:
    //       context.go("/contact");
    //       break;
    //     case 3:
    //       context.go("/orders");
    //       break;
    //     case 4:
    //       context.go("/account");
    //       break;
    //     default:
    //       context.go("/home");
    //       break;
    //   }
    // }

    ValueNotifier<int> selectedIndex = useState<int>(0);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 245, 250),
      // body: childElement,
      bottomSheet: PersistentTabView(
        context,
        controller: controller,
        navBarHeight: 65,
        padding: const NavBarPadding.all(10),
        screens: buildScreens(),
        items: navBarsItems(),
        confineInSafeArea: false,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.once,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 600),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          duration: Duration(milliseconds: 220),
          curve: Curves.ease,
        ),
        navBarStyle: NavBarStyle.style5,
      ),
    );
  }
}
