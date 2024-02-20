import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReUsableLoginButton extends HookConsumerWidget {
  final String buttonName;
  final LinearGradient colorGradient;
  final void Function() onTap;
  final IconData icon;
  const ReUsableLoginButton({
    super.key,
    required this.buttonName,
    required this.colorGradient,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      splashColor: Colors.orange,
      child: Ink(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
          gradient: colorGradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const SizedBox(
              width: 10,
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
