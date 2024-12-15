import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/widgets/app_colors.dart';
import '../utils/sharedpreference.dart';
import '../viewmodel/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstRun =  false;
  bool isLoggedIn =  false;
  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance.getBooleanValue("isLoggedIn").then((value){
      setState(() {
        isLoggedIn = value;
      });

      SplashService.gotoLanding(context,isLoggedIn);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            child: Center(
              child: SizedBox(
                  child: Image.asset('assets/images/sample_image.png')),
            )
          )),
    );
  }
}