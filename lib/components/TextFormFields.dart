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
    Key? key,
    required this.icons,
    required this.hintText,
    required this.keyboardType,
    required this.obscureText,
    required this.textFieldController,
    required this.iconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 107, 101, 101), width: 0.2),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 152, 141, 141), width: 0.2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 152, 141, 141), width: 0.2),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          icon: SizedBox(
            width: 20,
            height: 20,
            child: icons,
          ),
          label: Text(hintText),
          // suffix: iconButton,
          suffixIcon: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.visibility_off_outlined,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          labelStyle: const TextStyle(
            height: 0.1,
            color: Color.fromARGB(255, 107, 105, 105),
            fontSize: 16.0,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
        ),
      ),
    );
  }
}
