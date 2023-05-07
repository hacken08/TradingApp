import 'package:go_router/go_router.dart';
import 'package:trading_app/routers/route_names.dart';

import '../views/error.dart';
import '../views/home.dart';
import '../views/login.dart';
import '../views/register.dart';

final GoRouter router = GoRouter(
    initialLocation: "/",
    errorBuilder: (context, state) => const ErrorPage(),
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
          name: RouteNames.home,
          path: "/",
          builder: (context, state) => const HomePage()),
      GoRoute(
          name: RouteNames.login,
          path: "/login",
          builder: (context, state) => const LoginPage()),
      GoRoute(
          name: RouteNames.register,
          path: "/register",
          builder: (context, state) => const RegisterPage()),
    ]);
