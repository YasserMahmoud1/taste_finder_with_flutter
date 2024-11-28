import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';

class AppMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final currentUser = FirebaseAuth.instance.currentUser;

    // Avoid redirecting to the same route to prevent infinite loops
    if (currentUser == null && route != "/onboarding") {
      return RouteSettings(name: "/onboarding");
    } else if (currentUser != null && route != "/") {
      return RouteSettings(name: "/");
    }
    return null; // No redirection needed
  }
}
