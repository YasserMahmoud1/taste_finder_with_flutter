import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taste_finder/locale/locale.dart';
import 'package:taste_finder/locale/locale_controller.dart';
import 'package:taste_finder/middelware/app_middleware.dart';
import 'package:taste_finder/services/shared_pref_service.dart';
import 'package:taste_finder/services/theme_manager.dart';
import 'package:taste_finder/views/categoty_details/category_details_page.dart';
import 'package:taste_finder/views/home/home_page.dart';
import 'package:taste_finder/views/login/login_page.dart';
import 'package:taste_finder/views/onboarding/onboarding_page.dart';
import 'package:taste_finder/views/register/register_page.dart';
import 'package:taste_finder/views/restaurant_details/restaurant_details_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localController = Get.put(LocaleController());
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
            MediaQuery.platformBrightnessOf(context) == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.darkTheme,
      themeMode: SharedPrefService.getTheme(),
      initialRoute: "/",
      locale: localController.initLang,
      translations: MyLocale(),
      getPages: [
        GetPage(
            name: "/", page: () => HomePage(), middlewares: [AppMiddleware()]),
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/register", page: () => RegisterPage()),
        GetPage(name: "/categoryDetails", page: () => CategoryDetailsPage()),
        GetPage(name: "/onboarding", page: () => OnboardingPage()),
        GetPage(
            name: "/restaurantDetails", page: () => RestaurantDetailsPage()),
        GetPage(name: "/photo_gallery", page: () => FullScreenGallery()),
      ],
    );
  }
}
