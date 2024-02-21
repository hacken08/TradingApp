import 'package:go_router/go_router.dart';
import 'package:trading_app/routers/route_names.dart';
import 'package:trading_app/states/mainstate.dart';
import 'package:trading_app/views/mains/order/top_bar.dart';
import 'package:trading_app/views/mains/settings.dart';
import 'package:trading_app/views/chat/chat_page.dart';
import 'package:trading_app/views/chat/contact_list.dart';
import 'package:trading_app/views/mains/watchlist.dart';
import 'package:trading_app/views/profile/editprofile.dart';
import 'package:trading_app/views/chat/searchuser.dart';
import 'package:trading_app/views/mains/wallet.dart';
import 'package:trading_app/views/profile/profile_visit.dart';

import '../components/bottomnav.dart';
import '../views/error.dart';
import '../views/login.dart';
import '../views/mains/notification.dart';
import '../views/mains/stockdata.dart';
import '../views/on_boarding.dart';
import '../views/register.dart';
import '../views/Trades/treding_and_search.dart';

final GoRouter router = GoRouter(
  initialLocation: "/onboard",
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      name: RouteNames.home,
      path: "/home",
      builder: (context, state) => const BoottomNavBar(),
    ),

    GoRoute(
      name: RouteNames.walletInfo,
      path: "/wallet/:id",
      builder: (context, state) => WalletInfo(
        id: int.parse(state.pathParameters["id"]!),
      ),
    ),

    GoRoute(
      name: RouteNames.visitprofile,
      path: "/visitprofile/:id",
      builder: (context, state) => ProfileVisitpage(
        id: int.parse(state.pathParameters["id"]!),
      ),
    ),

    GoRoute(
      name: RouteNames.notification,
      path: "/notification",
      builder: (context, state) => const NotificaionPage(),
    ),

    GoRoute(
      name: RouteNames.orders,
      path: "/orders",
      builder: (context, state) => const OrderPage(),
    ),
    GoRoute(
      name: RouteNames.trendingstock,
      path: "/trendingstock",
      builder: (context, state) => const TrendingStock(),
    ),
    GoRoute(
      name: RouteNames.stockdata,
      path: "/stockdata",
      builder: (context, state) => const StockData(),
    ),
    GoRoute(
      name: RouteNames.watchlist,
      path: "/watchlist",
      builder: (context, state) => const WishListPage(),
    ),
    // GoRoute(
    //   name: RouteNames.home,
    //   path: "/home",
    //   builder: (context, state) => const HomePage(),
    // ),

    // ShellRoute(
    //   routes: [
    //     GoRoute(
    //       name: RouteNames.home,
    //       path: "/home",
    //       builder: (context, state) => const HomePage(),
    //     ),
    //
    //     GoRoute(
    //       name: RouteNames.trading,
    //       path: "/trades",
    //       builder: (context, state) => const Trades(),
    //     ),
    //     GoRoute(
    //       name: RouteNames.protfolio,
    //       path: "/protfolio",
    //       builder: (context, state) => const PortfolioPage(),
    //     ),
    //     GoRoute(
    //       name: RouteNames.orders,
    //       path: "/orders",
    //       builder: (context, state) => const OrderPage(),
    //     ),
    //     GoRoute(
    //         name: RouteNames.profile,
    //         path: "/account",
    //         builder: (context, state) => const AccountPage(),
    //         routes: [
    //           GoRoute(
    //             name: RouteNames.walletInfo,
    //             path: "wallet/:id",
    //             builder: (context, state) => WalletInfo(
    //               id: int.parse(state.pathParameters["id"]!),
    //             ),
    //           ),
    //         ]),
    //     GoRoute(
    //       name: RouteNames.notification,
    //       path: "/notification",
    //       builder: (context, state) => const NotificaionPage(),
    //     ),
    //     GoRoute(
    //       name: RouteNames.buySell,
    //       path: "/buysell",
    //       builder: (context, state) => const BuySell(),
    //     ),
    //     GoRoute(
    //       name: RouteNames.visitprofile,
    //       path: "/visitprofile/:id",
    //       builder: (context, state) => ProfileVisitpage(
    //         id: int.parse(state.pathParameters["id"]!),
    //       ),
    //     ),
    //     GoRoute(
    //       name: RouteNames.searchStock,
    //       path: '/searchStock',
    //       builder: (context, state) => const TrendingStock(),
    //     ),
    //     GoRoute(
    //       name: RouteNames.stockBuyPage,
    //       path: '/stockBuyPage',
    //       builder: (context, state) => const StockBuyPage(),
    //     ),
    //   ],
    //   builder: (BuildContext context, GoRouterState state, Widget child) {
    //     return BoottomNavBar(
    //       childElement: child,
    //     );
    //   },
    // ),
    GoRoute(
      name: RouteNames.settings,
      path: "/settings",
      builder: (context, state) => const SettingPage(),
    ),
    GoRoute(
      name: RouteNames.editprofile,
      path: "/editprofile",
      builder: (context, state) => const ProfileCreating(),
    ),
    GoRoute(
      name: RouteNames.contact,
      path: "/contact",
      builder: (context, state) => const ChatList(),
      routes: [
        GoRoute(
          name: RouteNames.chat,
          path: "chat/:reciver",
          builder: (context, state) {
            return ChatPage(
                reciver: int.parse(state.pathParameters["reciver"] ?? "1"));
          },
        ),
      ],
    ),
    GoRoute(
      name: RouteNames.searchuser,
      path: "/searchuser",
      builder: (context, state) => const SearchUser(),
    ),
    GoRoute(
      name: RouteNames.login,
      path: "/login",
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) async {
        MainState mainState = MainState();
        final isLogin = await mainState.getLogin();
        if (isLogin) {
          return "/home";
        }
        return null;
      },
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
        final isOnboard = await mainState.getOnboard();
        if (isOnboard) {
          return "/login";
        }
        return null;
      },
    ),
  ],
);
