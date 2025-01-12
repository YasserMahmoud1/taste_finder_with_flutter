import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final rePasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPasswordShown = false;
  bool isRePasswordShown = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "register".tr,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (s) {
                          if (s == null || s.isEmpty) {
                            return "noName".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "name".tr,
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
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
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !isPasswordShown,
                        validator: (s) {
                          if (s == null || s.isEmpty) {
                            return "noPassword".tr;
                          } else if (!_isValidPassword(s)) {
                            return "notValidPassword".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "password".tr,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordShown = !isPasswordShown;
                                });
                              },
                              icon: Icon(isPasswordShown
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: TextFormField(
                        controller: rePasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !isRePasswordShown,
                        validator: (s) {
                          if (s == null || s.isEmpty) {
                            return "noPasswordAgain".tr;
                          } else if (s != passwordController.text) {
                            return "notValidPasswordAgain".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "passwordConfirmation".tr,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isRePasswordShown = !isRePasswordShown;
                                });
                              },
                              icon: Icon(isRePasswordShown
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
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
                            try {
                              final user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(user.user!.uid)
                                  .set(
                                {
                                  "Name": nameController.text.trim(),
                                  "Email": emailController.text.trim(),
                                  "Favorites": []
                                },
                              );
                              Get.offAndToNamed("/");
                            } catch (e) {
                              Get.snackbar(
                                "Register Error",
                                e.toString(),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: Text(
                            "register".tr,
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
                          Text("haveAnAccount".tr),
                          SizedBox(width: 4),
                          TextButton(
                              onPressed: () {
                                Get.offAndToNamed("/login");
                              },
                              child: Text("login".tr)),
                        ],
                      ),
                    )
                  ],
                ),
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
