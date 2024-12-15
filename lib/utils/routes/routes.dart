import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_project/utils/routes/route_names.dart';
import 'package:test_project/view/register_screen.dart';

import '../../view/home_screen.dart';
import '../../view/login_screen.dart';
import '../../view/onboarding_screen.dart';
import '../../view/splash_screen.dart';

class Routes {
  User? user;

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.onboardingScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnboardingScreen());
      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case (RouteNames.loginScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) =>  LoginScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
