import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/alerts.dart';

enum UserData {
  id,
  token,
  role,
}

final userState =
    ChangeNotifierProvider.autoDispose<UserState>((ref) => UserState());

class UserState extends ChangeNotifier {
  String userloc = "user";

  File? imageFile;

  Future<bool> setUser(int id, String role, String token) async {
    var result = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = {"id": id, "role": role, "token": token};
    result = await prefs.setString(userloc, jsonEncode(user));
    return result;
  }

  Future<bool> isUser() async {
    bool result = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? res = prefs.getString(userloc);
    if (res == null) {
      return false;
    }
    return result;
  }

  Future<bool> clearUser() async {
    bool result = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    result = await prefs.remove(userloc);
    return result;
  }

  Future<dynamic> getUserData(UserData userdata, BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(userloc);
    if (user == null) {
      if (context.mounted) {
        context.go("/");
        return erroralert(context, "Error!", "User Not Exist.");
      }
    }

    if (userdata == UserData.id) {
      return jsonDecode(user!)["id"];
    }
    if (userdata == UserData.token) {
      return jsonDecode(user!)["token"];
    }
    if (userdata == UserData.role) {
      return jsonDecode(user!)["role"];
    }
    return false;
  }

  Future<void> uploadImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageFile = imageTemp;
    } on PlatformException catch (e) {
      if (context.mounted) {
        erroralert(context, "Error", 'Failed to pick image: $e');
      }
    }
    notifyListeners();
  }
}
