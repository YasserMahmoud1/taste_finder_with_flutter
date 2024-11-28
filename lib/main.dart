import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/middelware/app_middleware.dart';
import 'package:taste_finder/views/category_details_page.dart';
import 'package:taste_finder/views/home_page.dart';
import 'package:taste_finder/views/login_page.dart';
import 'package:taste_finder/views/onboarding_page.dart';
import 'package:taste_finder/views/register_page.dart';
import 'package:taste_finder/views/restaurant_details_page.dart';
import 'package:taste_finder/views/settings_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(
            name: "/", page: () => HomePage(), middlewares: [AppMiddleware()]),
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/register", page: () => RegisterPage()),
        GetPage(name: "/categoryDetails", page: () => CategoryDetailsPage()),
        GetPage(name: "/onboarding", page: () => OnboardingPage()),
        GetPage(
            name: "/restaurantDetails", page: () => RestaurantDetailsPage()),
        GetPage(name: "/settings", page: () => SettingsPage()),
      ],
    );
  }
}
