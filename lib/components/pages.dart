// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trading_app/states/onboardstate.dart';

class ReUsableOnBoardingPage extends HookConsumerWidget {
  final String imagePath;
  final String highlight;
  final String highlighDecription;
  final Color bgColor;
  final String guideText;
  final IconData inDesignIcon;

  const ReUsableOnBoardingPage({
    super.key,
    required this.imagePath,
    required this.highlight,
    required this.highlighDecription,
    required this.bgColor,
    required this.guideText,
    required this.inDesignIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onBoardStateW = ref.watch(onBoardState);
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: width,
            child: Center(
              child: Image.asset(
                imagePath,
                height: width * 0.8,
                width: width * 0.8,
              ),
            ),
          ),

          // Text
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Text(
                highlight,
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: width * 0.4,
              height: 2,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              highlighDecription,
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: onBoardStateW.index,
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
          const SizedBox(
            height: 20,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                guideText,
                style: const TextStyle(
                  fontSize: 20.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  onBoardStateW.nextPage(context);
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Icon(
                    inDesignIcon,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
