import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/routers/route_names.dart';
import 'package:trading_app/states/mainstate.dart';
import 'package:trading_app/views/mains/home.dart';
import 'package:trading_app/views/mains/account.dart';
import 'package:trading_app/views/mains/notification.dart';
import 'package:trading_app/views/mains/order.dart';
import 'package:trading_app/views/mains/protfolio.dart';
import 'package:trading_app/views/mains/settings.dart';
import 'package:trading_app/views/mains/wishlist.dart';

import '../components/bottomnav.dart';
import '../views/error.dart';
import '../views/login.dart';
import '../views/onBoarding.dart';
import '../views/register.dart';

final GoRouter router = GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          name: RouteNames.home,
          path: "/home",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: RouteNames.watchlist,
          path: "/watchlist",
          builder: (context, state) => const WishListPage(),
        ),
        GoRoute(
          name: RouteNames.protfolio,
          path: "/protfolio",
          builder: (context, state) => const PortfolioPage(),
        ),
        GoRoute(
          name: RouteNames.orders,
          path: "/orders",
          builder: (context, state) => const OrderPage(),
        ),
        GoRoute(
          name: RouteNames.account,
          path: "/account",
          builder: (context, state) => const AccountPage(),
        ),
        GoRoute(
          name: RouteNames.notification,
          path: "/notification",
          builder: (context, state) => const NotificaionPage(),
        ),
        GoRoute(
          name: RouteNames.settings,
          path: "/settings",
          builder: (context, state) => const SettingPage(),
        ),
      ],
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BoottomNavBar(
          childElement: child,
        );
      },
    ),
    // GoRoute(
    //     name: RouteNames.login,
    //     path: "/login",
    //     // redirect: (context, state) async {
    //     //   log("two");
    //     //   MainState mainState = MainState();
    //     //   await mainState.init();
    //     //   final isLogin = await mainState.getLogin();
    //     //   log(isLogin.toString());
    //     //   if (isLogin) {
    //     //     log("three");

    //     //     return "/home";
    //     //   }
    //     //   return null;
    //     // },
    //     builder: (context, state) => const LoginPage(),
    //     routes: [
    //       GoRoute(
    //         name: RouteNames.register,
    //         path: "register",
    //         builder: (context, state) => const RegisterPage(),
    //       ),
    //     ]),
    GoRoute(
      name: RouteNames.login,
      path: "/login",
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          name: RouteNames.register,
          path: "register",
          builder: (context, state) => const RegisterPage(),
        ),
      ],
    ),
    GoRoute(
      name: RouteNames.onboard,
      path: "/onboard",
      builder: (context, state) => const OnBoardingScreens(),
      redirect: (context, state) async {
        MainState mainState = MainState();
        await mainState.init();
        final isOnboard = await mainState.getOnboard();
        if (isOnboard) {
          return "/login";
        }
        return null;
      },
    ),
  ],
);
