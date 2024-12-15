import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/firbase_auth_helper.dart';
import '../utils/sharedpreference.dart';
import '../view/home_screen.dart';

class LoginViewModel extends ChangeNotifier{
  LoginViewModel(){
    notifyListeners();
  }
  bool _isloading = false;
  bool get isloading => _isloading;
  set isloading(bool isloading) => _isloading = isloading;

  Future<void> signIn(String email, String password,BuildContext context,)async {
      _isloading = true;
      notifyListeners();
      print('email'+email);
      print('password'+password);
      User? user = await FirebaseAuthHelper.signInUsingEmailPassword(
        email:email,
        password: password,
      );
      if (user != null) {
        _isloading = false;

        notifyListeners();
        MySharedPreferences.instance
            .setBooleanValue("isLoggedIn", true);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => new HomeScreen(user)),
                (Route<dynamic> route) => false
        );
      }else{
        _isloading = false;
        notifyListeners();

        Fluttertoast.showToast(
          msg: "Login Failed!.. Invalid Credentials",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
  }

}