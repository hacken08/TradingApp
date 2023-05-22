// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReUsableOnBoardingPage extends HookConsumerWidget {
  final String imagePath;
  final String highlight;
  final String highlighDecription;
  final Color bgColor;
  final String guideText;
  final double imageHeight;
  final double imageWidth;
  final IconData inDesignIcon;

  const ReUsableOnBoardingPage({
    super.key,
    required this.imagePath,
    required this.highlight,
    required this.highlighDecription,
    required this.bgColor,
    required this.guideText,
    required this.imageHeight,
    required this.imageWidth,
    required this.inDesignIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _SwipeController = LiquidController();
    return Container(
        color: bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                width: 500,
                height: 350,
                child: Image.asset(imagePath,
                    height: imageHeight, width: imageWidth),
              ),
            ),

            // Text
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Text(
                highlight,
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                width: 310,
                child: Text(
                  highlighDecription,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: AnimatedSmoothIndicator(
                activeIndex: _SwipeController.currentPage,
                count: 3,
                effect: const WormEffect(
                    dotWidth: 35,
                    radius: 12.2,
                    dotHeight: 5,
                    spacing: 15,
                    dotColor: Color.fromARGB(255, 204, 201, 201),
                    activeDotColor: Colors.black,
                    paintStyle: PaintingStyle.fill),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      guideText,
                      style: const TextStyle(
                          fontSize: 20.3, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.black,
                    ),
                    child: Icon(
                      inDesignIcon,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
