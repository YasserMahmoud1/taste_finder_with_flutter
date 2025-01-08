import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taste_finder/services/shared_pref_service.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (SharedPrefService.getThemeString() == "sys") {
      isDark.value =
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark;
    } else {
      isDark.value = SharedPrefService.getThemeString() == "dark";
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (SharedPrefService.getThemeString() == "sys") {
      isDark.value =
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark;
    }
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  changeTheme(String newTheme, BuildContext context) async {
    SharedPrefService.setTheme(newTheme);
    if (newTheme == "dark") {
      isDark.value = true;
      Get.changeThemeMode(ThemeMode.dark);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      );
    } else if (newTheme == "light") {
      isDark.value = false;
      Get.changeThemeMode(ThemeMode.light);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    } else if (newTheme == "sys") {
      isDark.value =
          MediaQuery.platformBrightnessOf(context) == Brightness.dark;
      Get.changeThemeMode(ThemeMode.system);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness:
              MediaQuery.platformBrightnessOf(context) == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
        ),
      );
    }
  }
}
