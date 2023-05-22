// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReusableListView extends StatelessWidget {
  final IconData icon;
  final String label;
  final String info;
  final double labelPadding;
  final double iconPadding;
  final void Function() onTap;
  const ReusableListView({
    super.key,
   required this.onTap,
    required this.icon,
    required this.label,
    required this.labelPadding,
    required this.iconPadding,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(right: labelPadding),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(255, 143, 143, 143)),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 23, bottom: 15),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 10),
              child: Text(
                info,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(left: iconPadding),
              child: IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.mode_edit_outlined,
                    size: 26,
                    color: Colors.grey,
                  )),
            )
          ],
        ),
      ],
    );
  }
}
