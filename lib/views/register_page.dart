import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                      "Register",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Gap(24),
                    Center(
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (s) {
                          if (s == null || s.isEmpty) {
                            return "You must enter the Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    Gap(8),
                    Center(
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (s) {
                          if (s == null || s.isEmpty) {
                            return "You must enter the email";
                          } else if (!_isValidEmail(s)) {
                            return "You must Enter a valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    Gap(8),
                    Center(
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (s) {
                          if (s == null || s.isEmpty) {
                            return "You must enter the password";
                          } else if (!_isValidPassword(s)) {
                            return "The password must be at least 8 characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove_red_eye)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    Gap(8),
                    Center(
                      child: TextFormField(
                        controller: rePasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (s) {
                          if (s == null || s.isEmpty) {
                            return "You must enter the password again";
                          } else if (s != passwordController.text) {
                            return "The passwords must match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password Confirmation",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove_red_eye)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    Gap(16),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.purple)),
                          onPressed: () {
                            // debugPrint(nameController.text);
                            // debugPrint(emailController.text);
                            // debugPrint(passwordController.text);
                            // debugPrint(rePasswordController.text);
                            // if (formKey.currentState!.validate()) {
                            //   debugPrint("it's ok to register");
                            // }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Gap(16),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Already have an account?"),
                          Gap(3),
                          TextButton(
                              onPressed: () {
                                Get.offAndToNamed("/login");
                              },
                              child: Text("Login")),
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
