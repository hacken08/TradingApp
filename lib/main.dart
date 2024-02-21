import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:trading_app/routers/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: Trading(),
    ),
  );
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//     ProviderScope(
//       child: DevicePreview(
//         builder: (context) => const Trading(),
//       ),
//     ),
//   );
// }

class Trading extends HookConsumerWidget {
  const Trading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> isDeviceConnected = useState<bool>(false);

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        isDeviceConnected.value =
            await InternetConnectionChecker().hasConnection;
      }
    });

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Trading App",
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        routerConfig: router,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
