import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Gap(24),
              Center(
                child: TextFormField(
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
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
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
                        backgroundColor: WidgetStatePropertyAll(Colors.purple)),
                    onPressed: () {},
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Gap(16),
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
                        Text("Sign In With Google"),
                        Gap(4),
                        Image.asset(
                          "assets/images/Google.png",
                          scale: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Does not have an account yet?"),
                    Gap(3),
                    TextButton(
                        onPressed: () {
                          Get.offAndToNamed("/register");
                        },
                        child: Text("Register")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
