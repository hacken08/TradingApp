import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReUsableButton extends HookConsumerWidget {
  final String buttonName;
  final LinearGradient colorGradient;
  final void Function() onTap;
  final IconData icon;
  const ReUsableButton({
    super.key,
    required this.buttonName,
    required this.colorGradient,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      splashColor: Colors.orange,
      child: Ink(
        width: 360,
        height: 50,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(blurRadius: 3.3),
          BoxShadow(blurStyle: BlurStyle.normal),
          BoxShadow(offset: Offset.zero)
        ], borderRadius: BorderRadius.circular(10), gradient: colorGradient),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Icon(
              icon,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }
}
