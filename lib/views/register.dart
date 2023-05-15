import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  Image.asset(
                    'assets/images/signUp.png',
                  ),

                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        fontFamily: 'abel'),
                  ),
                  const Text(
                    "Create your Demant account",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'abel'),
                  ),

                  // -------------username-----------------
                  // reUsableTextFormField(
                  //     const Icon(
                  //       Icons.person_2_outlined,
                  //       color: Color.fromARGB(255, 52, 51, 51),
                  //     ),
                  //     "Username",
                  //     TextInputType.visiblePassword,
                  //     true,
                  //     _passwordController,
                  //     const Text(
                  //       '',
                  //       style: TextStyle(fontSize: 35),
                  //     )),

                  // ---------------Email Id-----------------
                  // reUsableTextFormField(
                  //     Image.asset('assets/icons/@.png'),
                  //     "Email ID",
                  //     TextInputType.emailAddress,
                  //     false,
                  //     _emailController,
                  //     const Text(
                  //       '',
                  //       style: TextStyle(fontSize: 35),
                  //     )),

                  // ---------------password-----------------
                  // reUsableTextFormField(
                  //     const Icon(
                  //       Icons.lock_outline,
                  //       color: Color.fromARGB(255, 52, 51, 51),
                  //     ),
                  //     "password",
                  //     TextInputType.visiblePassword,
                  //     true,
                  //     _passwordController,
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(Icons.remove_red_eye_outlined),
                  //       splashRadius: 0.1,
                  //       color: Colors.grey,
                  //     )),

                  Row(
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

                  ReUsableButton(
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

                  Row(
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
                ],
              ),
            )),
      ),
    );
  }
}
