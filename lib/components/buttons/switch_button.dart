import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ReCustomWitchButton extends StatelessWidget {
  // final double leftPadding;
  // final void Function() onDoubleTap;
  // final void Function() onSwipe;
  // final dynamic Function(bool) onChange;
  // final void Function() onTap;
  // final double width;
  const ReCustomWitchButton({
    super.key,
    // super.key,
    // required this.onTap,
    // required this.onDoubleTap,
    // required this.onChange,
    // required this.onSwipe,
    // required this.leftPadding,
    // required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      width: 54,
      child: LiteRollingSwitch(
        //initial value
        value: true, width: 64,
        animationDuration: const Duration(milliseconds: 300),
        textOn: ' ',
        textOff: ' ',
        colorOn: Colors.deepPurple,
        colorOff: const Color.fromARGB(255, 196, 190, 190),
        iconOn: Icons.donut_large_outlined,
        iconOff: Icons.remove_circle_outline,
        textSize: 16.0,
        onChanged: (change) {},
        onDoubleTap: () {},
        onSwipe: () {},
        onTap: () {},
      ),
    );
  }
}
