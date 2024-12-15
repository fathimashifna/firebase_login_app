import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';

import '../utils/routes/route_names.dart';
import '../utils/sharedpreference.dart';
import '../view/home_screen.dart';

class SplashService {
  static void gotoLanding(BuildContext context, bool isLoggedIn) async {
      await Future.delayed(const Duration(seconds: 3));
      bool firstRun = await IsFirstRun.isFirstRun();
      if( firstRun){
        Navigator.pushNamed(context, RouteNames.onboardingScreen);
      }else
        {
          if( isLoggedIn ){
            _initializeFirebase(context);

          }else
          {
            Navigator.pushNamed(context, RouteNames.loginScreen);

          }
        }



  }
  static Future<FirebaseApp> _initializeFirebase(BuildContext context) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => new HomeScreen(user)),
              (Route<dynamic> route) => false
      );
    }
    return firebaseApp;
  }
}