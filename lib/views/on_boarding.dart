import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/components/pages.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:trading_app/states/mainstate.dart';
import 'package:trading_app/themes/colors.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final swipeController = LiquidController();

  int index = 0;
  MainState mainState = MainState();

  Future<void> nextpage() async {
    if (index < 2) {
      swipeController.animateToPage(page: index + 1, duration: 500);
    } else {
      await mainState.setOnboard(true);
      if (context.mounted) context.go("/login");
    }
    setState(() {
      index = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: LiquidSwipe(
          disableUserGesture: false,
          onPageChangeCallback: (value) {
            setState(() {
              index = value;
            });
          },
          preferDragFromRevealedArea: true,
          liquidController: swipeController,
          fullTransitionValue: 480,
          pages: [
            ReUsableOnBoardingPage(
              index: index,
              imagePath: 'assets/images/ob_3.png',
              highlight: "On Boarding 1",
              highlighDecription:
                  "Welcome and start your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
              bgColor: Colors.white,
              guideText: "Swipe Right",
              inDesignIcon: Icons.arrow_forward_ios,
              controller: swipeController,
              nextPage: nextpage,
            ),
            ReUsableOnBoardingPage(
              index: index,
              imagePath: 'assets/images/ob_2.png',
              highlight: "On Boarding 2",
              highlighDecription:
                  "Welcome and s1tart your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
              bgColor: const Color(0xfffddcdf),
              guideText: "Swipe Right",
              inDesignIcon: Icons.arrow_forward_ios,
              controller: swipeController,
              nextPage: nextpage,
            ),
            ReUsableOnBoardingPage(
              index: index,
              imagePath: 'assets/images/ob_1.png',
              highlight: "On Boarding 3",
              highlighDecription:
                  "Welcome and start your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
              bgColor: const Color(0xffffdcbd),
              guideText: "All Set",
              inDesignIcon: Icons.done,
              controller: swipeController,
              nextPage: nextpage,
            ),
          ],
          enableLoop: false,
          waveType: WaveType.liquidReveal,
        ),
      ),
    );
  }
}
