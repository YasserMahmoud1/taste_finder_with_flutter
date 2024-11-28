import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/Backdrop.jpg"),
          Text("Welcome"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.offAndToNamed("/login");
                },
                child: Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAndToNamed("/register");
                },
                child: Text("Registration"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
