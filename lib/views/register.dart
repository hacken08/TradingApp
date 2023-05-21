// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/textFormFields.dart';

import '../components/buttons/button.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var usernameController = useTextEditingController();
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 330, top: 20),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 20),
                    child: Image.asset(
                      'assets/images/signUp.png',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 225, bottom: 5),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: 'abel'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 180, bottom: 15, left: 5),
                    child: const Text(
                      "Create your Demant account",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'abel'),
                    ),
                  ),

                  // -------------username-----------------

                  ReUsableTextFormFields(
                    icons: Icon(
                      Icons.person_2_outlined,
                      color: Color.fromARGB(255, 52, 51, 51),
                    ),
                    hintText: "Username",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textFieldController: usernameController,
                    iconButton: const Text(
                      '',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),

                  // ---------------Email Id-----------------
                  ReUsableTextFormFields(
                    icons: Image.asset('assets/icons/@.png'),
                    hintText: "Email ID",
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    textFieldController: emailController,
                    iconButton: const Text(
                      '',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),

                  // ---------------password-----------------
                  ReUsableTextFormFields(
                      icons: const Icon(
                        Icons.lock_outline,
                        color: Color.fromARGB(255, 52, 51, 51),
                      ),
                      hintText: "password",
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      textFieldController: passwordController,
                      iconButton: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye_outlined),
                        splashRadius: 0.1,
                        color: Colors.grey,
                      )),

                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 30),
                    child: Row(
                      children: [
                        const Text(
                          "By Signing Up, Your're agree to our",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 107, 104, 104)),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Term & Conditions",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 50),
                    child: ReUsableLoginButton(
                      buttonName: "Sign Up",
                      colorGradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 139, 76),
                          Color.fromARGB(255, 251, 118, 47),
                        ],
                        end: Alignment.topLeft,
                        begin: Alignment.topRight,
                      ),
                      onTap: () {},
                      icon: Icons.login,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have account?",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                  
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
