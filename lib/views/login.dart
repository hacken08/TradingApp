// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/textFormFields.dart';
import 'package:trading_app/components/buttons/button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/trade login.png',
                    height: size.height * 0.4,
                    width: size.width * 0.8,
                  ),

                  const Padding(
                    padding: EdgeInsets.only(right: 265, bottom: 5),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: 'abel'),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(right: 180, bottom: 15, left: 5),
                    child: Text(
                      "Login to you Demant account",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'abel'),
                    ),
                  ),

                  // ------------------- Email ID -----------------------
                  ReUsableTextFormFields(
                      icons: Image.asset('assets/icons/@.png'),
                      hintText: "Email ID",
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      textFieldController: emailController,
                      iconButton: const Text(
                        '',
                        style: TextStyle(fontSize: 35),
                      )),

                  // -------------------- Password ---------------------
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
                    padding: const EdgeInsets.only(left: 190, top: 10),
                    child: TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        splashFactory:
                            InkSparkle.constantTurbulenceSeedSplashFactory,
                      ),
                      child: const Text(
                        "Forget Password ?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontFamily: 'abel',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ReUsableLoginButton(
                              buttonName: "Login",
                              colorGradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 139, 76),
                                  Color.fromARGB(255, 251, 118, 47),
                                ],
                                end: Alignment.topLeft,
                                begin: Alignment.topRight,
                              ),
                              onTap: () {},
                              icon: Icons.login)
                        ],
                      )),

                   Padding(
                    padding: EdgeInsets.only(
                      top: 6,
                      bottom: 6,
                    ),
                    
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          child: Divider(
                            thickness: 0.9,
                            color: Color.fromARGB(255, 227, 227, 227),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: 5, left: 15, right: 15),
                          child: Text(
                            " OR ",
                            style: TextStyle(
                                fontFamily: 'abel',
                                letterSpacing: 1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(184, 106, 100, 100)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 23,
                            bottom: 20,
                          ),
                          child: SizedBox(
                            width: 130,
                            child: Divider(
                              thickness: 0.9,
                              color: Color.fromARGB(255, 227, 227, 227),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: InkWell(
                      onTap: () {},
                      child: Ink(
                          width: 360,
                          height: 50, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: const Color.fromARGB(255, 241, 237, 237),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_logo.png',
                                  width: 35,
                                  height: 35,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 60),
                                  child: Text(
                                    "Login With Google",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Start Trading?",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
