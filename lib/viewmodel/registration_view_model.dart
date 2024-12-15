import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/firbase_auth_helper.dart';
import '../utils/sharedpreference.dart';
import '../view/home_screen.dart';

class RegistrationViewModel extends ChangeNotifier{
  RegistrationViewModel(){
    notifyListeners();
  }
  bool _isloading = false;
  bool get isloading => _isloading;

  Future<void> signUp(String name,String email,String password,BuildContext context,)async {
    _isloading = true;
    notifyListeners();
    User? user = await FirebaseAuthHelper.registerUsingEmailPassword(
      email:email,
      password: password, name:  name,
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
        msg: "Registration Failed!..",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }
}