import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/pages.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:trading_app/states/onboardstate.dart';

class OnBoardingScreens extends HookConsumerWidget {
  const OnBoardingScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final swipeController = LiquidController();
    final onBoardStateW = ref.watch(onBoardState);
    return Scaffold(
      body: SafeArea(
        child: LiquidSwipe(
          disableUserGesture: false,
          onPageChangeCallback: onBoardStateW.setPage,
          preferDragFromRevealedArea: true,
          liquidController: onBoardStateW.swipeController,
          fullTransitionValue: 480,
          pages: const [
            ReUsableOnBoardingPage(
              imagePath: 'assets/images/OB_3.png',
              highlight: "On Boarding 1",
              highlighDecription:
                  "Welcome and start your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
              bgColor: Colors.white,
              guideText: "Swipe Right",
              inDesignIcon: Icons.arrow_forward_ios,
            ),
            ReUsableOnBoardingPage(
              imagePath: 'assets/images/OB_2.png',
              highlight: "On Boarding 2",
              highlighDecription:
                  "Welcome and s1tart your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
              bgColor: Color(0xfffddcdf),
              guideText: "Swipe Right",
              inDesignIcon: Icons.arrow_forward_ios,
            ),
            ReUsableOnBoardingPage(
              imagePath: 'assets/images/OB_1.png',
              highlight: "On Boarding 3",
              highlighDecription:
                  "Welcome and start your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
              bgColor: Color(0xffffdcbd),
              guideText: "All Set",
              inDesignIcon: Icons.done,
            ),
          ],
          enableLoop: false,
          waveType: WaveType.liquidReveal,
        ),
      ),
    );
  }
}
