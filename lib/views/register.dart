// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/buttons/button.dart';
import '../services/api.dart';
import '../utils/utilsmethod.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var usernameController = useTextEditingController();
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();
    final size = MediaQuery.of(context).size;
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    ValueNotifier<bool> showPass = useState<bool>(false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height - statusbarHeight,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.09,),

                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: 'abel'),
                    ),
                  ), SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: const Text(
                      "Create your Demant account",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'abel'),
                    ),
                  ),SizedBox(height: 20,),
                  Spacer(),

                  // -------------username-----------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == "" || value == null || value.isEmpty) {
                          return "Enter your email";
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
                      controller: usernameController,
                      decoration: InputDecoration(
                        icon: SizedBox(
                          width: 40,
                          height: 20,
                          child: Image.asset('assets/icons/@.png', )
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
                        label: Text("Username"),
                        labelStyle: const TextStyle(
                          height: 0.1,
                          color: Color.fromARGB(255, 107, 105, 105),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                    SizedBox(height: 20),

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
                          child: Icon(
                            Icons.mail_outline,
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
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final data = await apiCall(
                              query:
                                  "mutation signup(\$signUpUserInput:SignUpUserInput!){signup (signUpUserInput:\$signUpUserInput){ id, token, role, email}} ",
                              variables: {
                                "signUpUserInput": {
                                  "name": usernameController.text,
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                }
                              },
                              headers: {
                                "content-type": "*/*"
                              });

                          if (data.status) {
                            context.go("/home");
                          } else {
                            var snackBar = SnackBar(
                              content: Text(
                                data.message,
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.redAccent,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      icon: Icons.login,
                    ),
                  ),
                    SizedBox(height: 20),

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
                        onPressed: () async {
                          context.go("/login");
                        },
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
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
