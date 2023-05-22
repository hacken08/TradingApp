import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReUsableTextFormFields extends HookConsumerWidget {
  final Widget icons;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController textFieldController;
  final Widget iconButton;

  const ReUsableTextFormFields({
    super.key,
    required this.icons,
    required this.hintText,
    required this.keyboardType,
    required this.obscureText,
    required this.textFieldController,
    required this.iconButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 45),
        child: TextFormField(
          controller: textFieldController,
          cursorColor: Colors.black,
          cursorWidth: 0.8,
          cursorHeight: 25,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 152, 141, 141), width: 0.2)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 152, 141, 141), width: 0.5)),
            icon: Padding(
              padding: const EdgeInsets.only(top: 30, right: 10),
              child: SizedBox(
                width: 20,
                height: 20,
                child: icons,
              ),
            ),
            label: Padding(
                padding: const EdgeInsets.only(top: 30, left: 5),
                child: Text(hintText)),
            suffix: iconButton,
            labelStyle: const TextStyle(
              height: 0.1,
              color: Color.fromARGB(255, 107, 105, 105),
              fontSize: 16.0,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}
