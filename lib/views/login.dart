import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/buttons/button.dart';
import 'package:trading_app/themes/colors.dart';

import '../services/api.dart';
import '../services/googlesignin.dart';
import '../states/mainstate.dart';
import '../states/userstate.dart';
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
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: SizedBox(
          height: size.height - statusbarHeight,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  // Image.asset('assets/images/trade login.png', scale: 9,),

                  const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      fontFamily: 'abel',
                    ),
                  ),
                  const SizedBox(height: 5),

                  const Text(
                    "Login to you Demant account",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'abel'),
                  ),
                  const SizedBox(height: 45),

                  // ------------------- Email ID -----------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      // horizontal: 20,
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
                            width: 30,
                            height: 20,
                            child: Image.asset(
                              'assets/icons/@.png',
                              scale: 10,
                            )),
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
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.8,
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
                        label: const Text("Email ID"),
                        labelStyle: const TextStyle(
                          height: 0.1,
                          color: Color.fromARGB(255, 107, 105, 105),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // ------------------- Password -----------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      // horizontal: 20,
                      vertical: 5,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == "" || value == null || value.isEmpty) {
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
                            width: 30,
                            height: 20,
                            child: Image.asset('assets/icons/lock.png')),
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
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.6,
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
                        label: const Text("Password"),
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
                  const SizedBox(
                    height: 9,
                  ),

                  // ------------------ Forget Button ------------------
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
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
                  const SizedBox(
                    height: 20,
                  ),

                  // ------------------ Login Button ------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final data = await apiCall(
                              query:
                                  "query signin(\$loginUserInput:LoginUserInput!){signin (loginUserInput:\$loginUserInput){ id, token, role}} ",
                              variables: {
                                "loginUserInput": {
                                  "useremail": emailController.text,
                                  "password": passwordController.text
                                }
                              },
                              headers: {
                                "content-type": "*/*"
                              });

                          if (data.status) {
                            await ref.watch(userState).setUser(
                                  data.data["signin"]["id"],
                                  data.data["signin"]["role"],
                                  data.data["signin"]["token"],
                                );
                            await ref.watch(mainState).setLogin(true);
                            if (context.mounted) context.go("/home");
                          } else {
                            var snackBar = SnackBar(
                              content: Text(
                                data.message,
                                textScaler: const TextScaler.linear(1),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              backgroundColor: Colors.redAccent,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        }
                      },
                      icon: Icons.login,
                    ),
                  ),

                  // ------------------ Divider line ------------------
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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

                  // ------------------ Google Login Button ------------------
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () async {
                        try {
                          final data = await GooglesignInApi.login();
                          log(data.toString());
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      child: Ink(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
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
                  const SizedBox(
                    height: 50,
                  ),

                  // ------------------ Register Button ------------------
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
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
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
