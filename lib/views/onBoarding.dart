// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, camel_case_types, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:trading_app/components/pages.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class onBoardingScreens extends StatefulWidget {
  onBoardingScreens({super.key});

  @override
  State<onBoardingScreens> createState() => _onBoardingScreensState();
}

class _onBoardingScreensState extends State<onBoardingScreens> {
int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final sizeOfDeivce = MediaQuery.of(context).size;
    final _SwipeController = LiquidController();

    return Scaffold(
      body: MaterialApp(
        home: Scaffold(
          body: LiquidSwipe(
            disableUserGesture: false,
            onPageChangeCallback: onChangeCallBack,
            preferDragFromRevealedArea: true,
            liquidController: _SwipeController,
            fullTransitionValue: 480,
            pages: [
              
              ReUsableOnBoardingPage
                ( 'assets/images/OB_3.png',
                  "On Boarding 1",
                  "Welcome and start your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
                  Colors.white,
                  "Swipe Right",
                  sizeOfDeivce.height * 0.5,
                  sizeOfDeivce.width * 0.5,
                  Icons.arrow_forward_ios
                ),

              ReUsableOnBoardingPage
                ( 'assets/images/OB_2.png',
                  "On Boarding 2",
                  "Welcome and s1tart your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
                  const Color(0xfffddcdf),
                  "Swipe Right",
                  sizeOfDeivce.height * 0.5,
                  sizeOfDeivce.width * 0.5,
                  Icons.arrow_forward_ios
                ),

              ReUsableOnBoardingPage
                ( 'assets/images/OB_1.png',
                  "On Boarding 3",
                  "Welcome and start your trade and wake bull of your life, Start Trading today. Welcome and s1tart your trade and wake bull of your life, Start Trading today",
                  const Color(0xffffdcbd),
                  "All Set",
                  sizeOfDeivce.height * 0.5,
                  sizeOfDeivce.width * 0.5, 
                  Icons.done
                ),
               ],
            enableLoop: false,
            waveType: WaveType.liquidReveal,
          ),
        ),
      ),
    );
  }

  void onChangeCallBack(int activePageIndex) {
    setState(() {
    currentPage = activePageIndex;

    });
  }
}
