import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final mainState =
    ChangeNotifierProvider.autoDispose<MainState>((ref) => MainState());

class MainState extends ChangeNotifier {
  late SharedPreferences prefs;
  String login = "login";
  String onboard = "onboard";

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setLogin(bool value) async {
    await prefs.setBool(login, value);
  }

  Future<bool> getLogin() async {
    bool result = false;
    final bool? res = prefs.getBool(login);
    if (res == null) {
      result = false;
    } else {
      result = res;
    }
    return result;
  }

  Future<void> setOnboard(bool value) async {
    await prefs.setBool(onboard, value);
  }

  Future<bool> getOnboard() async {
    bool result = false;
    final bool? res = prefs.getBool(onboard);
    if (res == null) {
      result = false;
    } else {
      result = res;
    }
    return result;
  }
}
