import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 80,
        children: [
          Image.asset("assets/images/Backdrop.jpg"),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              "welcomeMSG".tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.offAndToNamed("/login");
                    },
                    child: Text("login".tr),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAndToNamed("/register");
                    },
                    child: Text("register".tr),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
                  ),
                  onPressed: () async {
                    final googleSignIn = GoogleSignIn();
                    final firebaseAuth = FirebaseAuth.instance;
                    final googleUser = await googleSignIn.signIn();
                    final firestore = FirebaseFirestore.instance;
                    if (googleUser == null) {
                      return;
                    }
                    final googleAuth = await googleUser.authentication;
                    final OAuthCredential credential =
                        GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    // final UserCredential userCredential
                    final user =
                        await firebaseAuth.signInWithCredential(credential);
                    if (user.user != null) {
                      final u = await firestore
                          .collection("Users")
                          .doc(user.user!.uid)
                          .get();
                      if (!u.exists) {
                        await firestore
                            .collection('Users')
                            .doc(user.user!.uid)
                            .set({
                          'Email': user.user!.email,
                          'Name': user.user!.displayName,
                          'Favorites': [], // Initialize with an empty list
                        });
                      }
                      Get.offAndToNamed("/");
                    }
                  },
                  child: Container(
                    height: 24,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("googleContinue".tr),
                        SizedBox(width: 4),
                        Image.asset(
                          "assets/images/Google.png",
                          scale: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
