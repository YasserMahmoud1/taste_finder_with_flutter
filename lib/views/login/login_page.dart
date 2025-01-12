import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPasswordShown = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "login".tr,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: TextFormField(
                      controller: emailController,
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return "noEmail".tr;
                        } else if (!_isValidEmail(s)) {
                          return "notValidEmail".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "email".tr,
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: TextFormField(
                      controller: passwordController,
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return "noPassword".tr;
                        } else if (!_isValidPassword(s)) {
                          return "notValidPassword".tr;
                        }
                        return null;
                      },
                      obscureText: !isPasswordShown,
                      decoration: InputDecoration(
                        hintText: "password".tr,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordShown = !isPasswordShown;
                              });
                            },
                              icon: Icon(isPasswordShown? Icons.visibility_off :Icons.visibility)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.deepOrangeAccent)),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              Get.offAndToNamed("/");
                            } catch (e) {
                              Get.snackbar(
                                "Register Error",
                                e.toString(),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          }
                        },
                        child: Text(
                          "login".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("needRegister".tr),
                        SizedBox(width: 4),
                        TextButton(
                            onPressed: () {
                              Get.offAndToNamed("/register");
                            },
                            child: Text("register".tr)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Regular expression for validating email
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(r'^.{8,}$');
    return passwordRegex.hasMatch(password);
  }
}
