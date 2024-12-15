import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/view/login_screen.dart';
import 'dart:io' show Platform, exit;
import '../res/widgets/app_colors.dart';
import '../utils/sharedpreference.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  HomeScreen(this.user);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget textView(
      String text, double fontsize, Color color, FontWeight fontWeight) {
    return Text(text,
        style: GoogleFonts.inter(
            fontSize: fontsize, color: color, fontWeight: fontWeight));
  }
  final FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();

    MySharedPreferences.instance
        .setBooleanValue("isLoggedIn", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.color_primary,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
                onPressed: () => Platform.isIOS
                  ? exit(0)
                    : SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              ),
            ),
            title: SizedBox(
                height: 60,
                width: 160,
                child: Image.asset('assets/images/sample_image.png')),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
              ),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/user.png')),
              Container(
                padding: const EdgeInsets.only(top: 20.0, left: 25.0),
                alignment: Alignment.centerLeft,
                child: textView('Full Name', 14.0, Colors.black, FontWeight.w400),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.color_primary,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                    child: Text(
                      '${widget.user!.displayName.toString()}',
                      style: GoogleFonts.inter(
                          fontSize: 18.0, color: AppColors.color_text),
                    ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0, left: 25.0),
                alignment: Alignment.centerLeft,
                child: textView('Email', 14.0, Colors.black, FontWeight.w400),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.color_primary,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: Text(
                    '${widget.user!.email.toString()}',
                    style: GoogleFonts.inter(
                        fontSize: 18.0, color: AppColors.color_text),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: () {
                      signOut();
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        backgroundColor: WidgetStateProperty.all<Color>(
                            AppColors.color_primary),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side:
                                    BorderSide(color: AppColors.color_primary)))),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
