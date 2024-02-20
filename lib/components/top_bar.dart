import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final List<Widget> action;

  const TopBar({
    super.key,
    required this.action,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 244, 255),
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.only(top: 23.0),
          child: Text(
            textScaler: const TextScaler.linear(1),
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.5,
            ),
          ),
        ),
        actions: action,
      ),
    );
  }
}
