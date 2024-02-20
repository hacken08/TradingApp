import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          hintText: hintText,
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

//__________________________________________^-^_______________________________________________//

class ProfileTextFiel extends StatelessWidget {
  final Widget icon;
  final String hintText;
  final TextEditingController controller;
  final bool? enable;
  final TextInputType? textInputType;
  final String? Function(String?) validation;
  final List<TextInputFormatter>? inputformatter;
  final int? maxLength;

  const ProfileTextFiel({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.enable,
    this.textInputType,
    required this.validation,
    this.inputformatter,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 5,
      maxLength: maxLength,
      validator: validation,
      keyboardType: textInputType ?? TextInputType.text,
      enabled: enable ?? true,
      cursorColor: Colors.black,
      cursorWidth: 0.8,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      controller: controller,
      inputFormatters: const [],
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: icon,
        filled: false,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade700,
            width: 0.4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.14,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.14,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.14,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.14,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        hintText: hintText,
        labelStyle: const TextStyle(
          height: 0.1,
          color: Color.fromARGB(255, 107, 105, 105),
          fontSize: 16.0,
        ),
      ),
    );
  }
}
