import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/themes/colors.dart';
import '../states/mainstate.dart';
import '../states/userstate.dart';

void erroralert(BuildContext context, String title, String subTitle) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: subTitle,
        contentType: ContentType.failure,
      ),
    ),
  );
}

void susalert(BuildContext context, String title, String subTitle) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: subTitle,
        contentType: ContentType.success,
      ),
    ),
  );
}

void comingalert(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "Upcoming",
        message: "This feature is coming soon in next release",
        contentType: ContentType.help,
      ),
    ),
  );
}

void profileComplated(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: const Color.fromARGB(255, 0, 34, 68),
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/sad.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "incomplete Profile",
                textScaler: const TextScaler.linear(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'In order to use app first you have to complete you profile',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1),
                  selectionColor: const Color(0xAF6694e8),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Click here to complete your profile",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1),
                  selectionColor: const Color(0xAF6694e8),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  minimumSize: const Size.fromHeight(35),
                ),
                onPressed: () {
                  context.go("/editprofile");
                },
                child: const Text(
                  "Complete",
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void exitAlert(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteColor,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Exit!",
                textScaler: const TextScaler.linear(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to exit the app?',
                  style: TextStyle(
                    color: blackColor.withOpacity(0.55),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        // width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: roseColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SystemNavigator.pop();
                      },
                      child: Container(
                        // width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: indigoColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Exit",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void logoutAlert(BuildContext context, WidgetRef ref) async {
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteColor,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Logout!",
                textScaler: const TextScaler.linear(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(
                    color: blackColor.withOpacity(0.55),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        // width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: roseColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ref.watch(userState).clearUser();
                        ref.watch(mainState).setLogin(false);
                        context.go("/login");
                      },
                      child: Container(
                        // width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: indigoColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
