import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/routers/router.dart';
import 'package:trading_app/views/login.dart';
import 'package:trading_app/views/onBoarding.dart';
import 'package:trading_app/views/profile.dart';
import 'package:trading_app/views/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: Trading()));
}

class Trading extends HookConsumerWidget {
  const Trading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   title: "Trading App",
    //   theme: ThemeData(
    //     primaryColor: Colors.purple,
    //   ),
    //   routerConfig: router,
    // );
    return MaterialApp(
      home:  const ProfilePage (),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
    );
  }
}
