import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taste_finder/controllers/settings_controller.dart';
import 'package:taste_finder/locale/locale_controller.dart';

import '../../controllers/theme_controller.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  final SettingsController settingsController = Get.put(SettingsController());
  
  final langController = Get.find<LocaleController>();
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final Color backColor = themeController.isDark.value
            ? Colors.grey.shade900
            : Colors.grey.shade300;
        final Color forColor = themeController.isDark.value
            ? Colors.grey.shade800
            : Colors.grey.shade200;
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                SettingsHeader(),
                ThemeDropDown(backColor: backColor, themeController: themeController, forColor: forColor, settingsController: settingsController),
                LanguageDropDown(backColor: backColor, themeController: themeController, forColor: forColor, settingsController: settingsController, langController: langController),
                LogoutButton()
              ],
            ),
          ),
        );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Colors.purple)),
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;
    
            if (user != null) {
              for (var userInfo in user.providerData) {
                if (userInfo.providerId == "google.com") {
                  await GoogleSignIn().signOut();
                  debugPrint("Signed out from Google");
                } else if (userInfo.providerId == "password") {
                  debugPrint("Signed out from Email/Password");
                }
              }
              await FirebaseAuth.instance.signOut();
    
              Get.offAndToNamed("/onboarding");
            }
          },
          child: Text("logout".tr),
        ),
      ),
    );
  }
}

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({
    super.key,
    required this.backColor,
    required this.themeController,
    required this.forColor,
    required this.settingsController,
    required this.langController,
  });

  final Color backColor;
  final ThemeController themeController;
  final Color forColor;
  final SettingsController settingsController;
  final LocaleController langController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "language".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDark.value
                      ? Colors.white
                      : Colors.black),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: forColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(8),
                    style: TextStyle(
                      fontSize: 14,
                      color: themeController.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                    value: settingsController.language,
                    items: [
                      DropdownMenuItem(
                        value: "sys",
                        child: Text("system".tr),
                      ),
                      DropdownMenuItem(
                        value: "ar",
                        child: Text("arabic".tr),
                      ),
                      DropdownMenuItem(
                        value: "en",
                        child: Text("english".tr),
                      ),
                    ],
                    onChanged: (s) {
                      settingsController.changeLanguage(s!);
                      langController.changeLang(s);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeDropDown extends StatelessWidget {
  const ThemeDropDown({
    super.key,
    required this.backColor,
    required this.themeController,
    required this.forColor,
    required this.settingsController,
  });

  final Color backColor;
  final ThemeController themeController;
  final Color forColor;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "theme".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDark.value
                      ? Colors.white
                      : Colors.black),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: forColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    dropdownColor: forColor,
                    borderRadius: BorderRadius.circular(8),
                    style: TextStyle(
                      fontSize: 14,
                      color: themeController.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                    value: settingsController.theme,
                    items: [
                      DropdownMenuItem(
                        value: "sys",
                        child: Text(
                          "system".tr,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "light",
                        child: Text("light".tr),
                      ),
                      DropdownMenuItem(
                        value: "dark",
                        child: Text("dark".tr),
                      ),
                    ],
                    onChanged: (s) {
                      settingsController.changeTheme(s!);
                      themeController.changeTheme(s, context);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      width: double.infinity,
      color: Colors.purple,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "settings".tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
