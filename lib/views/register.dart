import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/states/mainstate.dart';

import '../components/buttons/button.dart';
import '../services/api.dart';
import '../states/userstate.dart';
import '../utils/utilsmethod.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var usernameController = useTextEditingController();
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    ValueNotifier<bool> showPass = useState<bool>(false);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(
                  height: 99,
                ),

                // ----------------------- Heading -----------------------
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      fontFamily: 'abel'),
                ),
                const SizedBox(
                  height: 6,
                ),

                const Text(
                  "Create your Demant account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'abel'),
                ),
                const SizedBox(height: 45),

                // -------------username-----------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: 20,
                    vertical: 5,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return "Username your email";
                      } else if (value.length < 3) {
                        return "Username should be longer then 3 character.";
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
                      icon: const SizedBox(
                        width: 40,
                        height: 20,
                        child: Icon(
                          Icons.person_outline,
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
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.7,
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
                      label: const Text("Username"),
                      labelStyle: const TextStyle(
                        height: 0.1,
                        color: Color.fromARGB(255, 107, 105, 105),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                // ------------------- Email ID -----------------------
                TextFormField(
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
                    icon: const SizedBox(
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
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade700,
                        width: 0.7,
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
                const SizedBox(height: 30),

                // ----------------------- Password -----------------------
                TextFormField(
                  validator: (value) {
                    if (value == "" || value == null || value.isEmpty) {
                      return "Please fill the password";
                    }

                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "Password must contain at least 1 uppercase letter";
                    }

                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return "Password must contain at least 1 lowercase letter";
                    }

                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Password must contain at least 1 numeric digit";
                    }

                    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
                      return "Password must contain at least 1 special character";
                    }

                    if (value.length < 8) {
                      return "Password must be at least 8 characters long";
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
                    icon: const SizedBox(
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
                const SizedBox(
                  height: 75,
                ),

                // ----------------------- SignUp Buton -----------------------
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
                                "mutation signup(\$signUpUserInput:SignUpUserInput!){signup (signUpUserInput:\$signUpUserInput){ id, token, role}} ",
                            variables: {
                              "signUpUserInput": {
                                "username": usernameController.text,
                                "email": emailController.text,
                                "password": passwordController.text,
                              }
                            },
                            headers: {
                              "content-type": "*/*"
                            });

                        if (data.status) {
                          await ref.watch(userState).setUser(
                                data.data["signup"]["id"],
                                data.data["signup"]["role"],
                                data.data["signup"]["token"],
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
                                  color: Colors.white, fontSize: 16),
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
                const SizedBox(
                  height: 10,
                ),

                // ----------------------- LogIn Button -----------------------
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
                      onPressed: () async => context.go("/login"),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 55,
                ),

                // ----------------------- Term & Conditions -----------------------
                const Center(
                  child: Text(
                    "By Signing Up, Your're agree to our",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 107, 104, 104)),
                  ),
                ),
                const Center(
                  child: Text(
                    "Term & Conditions",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
