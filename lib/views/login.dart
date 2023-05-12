import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/trade login.png',
                scale: 6.5,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 256, bottom: 5),
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
              // reUsableTextFormField(
              Image.asset('assets/icons/@.png'),
              // "Email ID",
              // TextInputType.emailAddress,
              // false,
              // emailController,
              const Text(
                '',
                style: TextStyle(fontSize: 35),
              ),
              const Icon(
                Icons.lock_outline,
                color: Color.fromARGB(255, 52, 51, 51),
              ),
              // "password",
              // TextInputType.visiblePassword,
              // true,
              // passwordController,
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_outlined),
                splashRadius: 0.1,
                color: Colors.grey,
              ),
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

              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(40),
                splashColor: Colors.orange,
                child: Ink(
                  width: 360,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(blurRadius: 3.3),
                      BoxShadow(blurStyle: BlurStyle.normal),
                      BoxShadow(offset: Offset.zero)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 139, 76),
                        Color.fromARGB(255, 251, 118, 47),
                      ],
                      end: Alignment.topLeft,
                      begin: Alignment.topRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Icon(
                        Icons.login,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 130,
                    child: Divider(
                      thickness: 0.9,
                      color: Color.fromARGB(255, 227, 227, 227),
                    ),
                  ),
                  Text(
                    " OR ",
                    style: TextStyle(
                        fontFamily: 'abel',
                        letterSpacing: 1,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(184, 106, 100, 100)),
                  ),
                  SizedBox(
                    width: 130,
                    child: Divider(
                      thickness: 0.9,
                      color: Color.fromARGB(255, 227, 227, 227),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  width: 360,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color.fromARGB(255, 241, 237, 237),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        width: 35,
                        height: 35,
                      ),
                      const Text(
                        "Login With Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                    onPressed: () => context.go("/register"),
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
            ]),
          )),
    ));
  }
}
