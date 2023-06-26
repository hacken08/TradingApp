// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/buttons/button.dart';

import '../utils/utilsmethod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();

    ValueNotifier<bool> showPass = useState<bool>(false);

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: SafeArea(
            child: SizedBox(
              height: size.height - statusbarHeight,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    SizedBox(height: 90,),
      
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: 'abel',
                        ),
                      ),
                    ), SizedBox(height: 5,),
                     Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        "Login to you Demant account",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            fontFamily: 'abel'),
                      ),
                    ),SizedBox(height: 40),
      
                    // ------------------- Email ID -----------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || value == null || value.isEmpty) {
                            return "Enter your email";
                          } else if (!validateEmail(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        cursorWidth: 0.8, 
                        cursorHeight: 25,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        controller: emailController,
                        decoration: InputDecoration(
                          icon: SizedBox(
                            width: 40,
                            height: 20,
                            child: Image.asset('assets/icons/@.png')
                          ),
                          filled: false,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          label: Text("Email ID"),
                          labelStyle: const TextStyle(
                            height: 0.1,
                            color: Color.fromARGB(255, 107, 105, 105),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ), 
                    SizedBox(height: 20),
                    // ------------------- Password -----------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || value == null || value.isEmpty || value.length < 8) {
                            return "Fill the password";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        cursorWidth: 0.8,
                        cursorHeight: 25,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        controller: passwordController,
                        obscureText: showPass.value,
                        decoration: InputDecoration(
                          icon: SizedBox(
                            width: 40, 
                            height: 20,
                            child: Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                          ),
                          filled: false,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                              width: 0.2,
                            ),
                          ),
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          label: Text("Password"),
                          suffixIcon: InkWell(
                            onTap: () => showPass.value = !showPass.value,
                            child: Icon(
                              showPass.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            height: 0.1,
                            color: Color.fromARGB(255, 107, 105, 105),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
      
                  // Forget pasword........
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.topRight,
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
      
                    SizedBox(height: 50,),
      
                    // Login button.........
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ReUsableLoginButton(
                        buttonName: "Login",
                        colorGradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 139, 76),
                            Color.fromARGB(255, 251, 118, 47),
                          ],
                          end: Alignment.topLeft,
                          begin: Alignment.topRight,
                        ),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.go("/home");
                          }
                        },
                        icon: Icons.login,
                      ),
                    ),
      
                    // Divider line.......
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.9,
                              color: Color.fromARGB(255, 227, 227, 227),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
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
                          Expanded(
                            child: Divider(
                              thickness: 0.9,
                              color: Color.fromARGB(255, 227, 227, 227),
                            ),
                          ),
                        ],
                      ),
                    ),
      
                    // Login With Google.......
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {},
                        child: Ink(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: const Color.fromARGB(255, 241, 237, 237),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_logo.png',
                                  width: 35,
                                  height: 35,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Login With Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    Spacer(),
      
                  // Register button........
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Start Trading?",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go("/login/register");
                          },
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}