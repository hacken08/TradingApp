import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

final appTheme = ChangeNotifierProvider.autoDispose<AppTheme>(
  (ref) => AppTheme(),
);

class AppTheme extends ChangeNotifier {
  late SharedPreferences prefs;
  bool isLight = true;

  Future<void> init(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    // final theme = prefs.getString("theme");
  }

  Future<void> setDarkTheme() async {
    prefs.setString("theme", "dark");
    isLight = false;
    notifyListeners();
  }

  Future<void> setLightTheme() async {
    prefs.setString("theme", "light");
    isLight = true;
    notifyListeners();
  }

  Future<void> setSystemTheme(BuildContext context) async {
    prefs.setString("theme", "system");
    var brightness = MediaQuery.of(context).platformBrightness;
    isLight = brightness == Brightness.light;
    notifyListeners();
  }
}

Color appBarColor = const Color.fromARGB(255, 248, 244, 255);
Color whiteColor = const Color(0xffffffff);
Color blackColor = const Color(0xff000000);

Color redColor = const Color(0xffef4444);
Color roseColor = const Color(0xfff43f5e);
Color pinkColor = const Color(0xffec4899);

Color indigoColor = const Color(0xff6366f1);
Color violetColor = const Color(0xff8b5cf6);
Color purpleColor = const Color(0xffa855f7);
Color fuchsiaColor = const Color(0xffd946ef);

Color blueColor = const Color(0xff3b82f6);
Color cyanColor = const Color(0xff06b6d4);
Color skyColor = const Color(0xff0ea5e9);

Color greenColor = const Color(0xff22c55e);
Color emeraldColor = const Color(0xff10b981);
Color tealColor = const Color(0xff14b8a6);

Color orangeColor = const Color(0xfff97316);
Color yellowColor = const Color(0xffeab308);
Color anberColor = const Color(0xfff59e0b);

Color slateColor = const Color(0xff64748b);
Color grayColor = const Color(0xff6b7280);
Color zincColor = const Color(0xff71717a);
Color stoneColor = const Color(0xff78716c);
Color neutralColor = const Color(0xff737373);

Color appBackgroundColor = Colors.white;
