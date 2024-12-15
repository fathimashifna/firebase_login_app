import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/routes/route_names.dart';

class OnboardingViewModelProvider with ChangeNotifier,DiagnosticableTreeMixin{
  double? _page = 0;

  bool? isFresher;
  bool? isLoading;

  double? get page => _page;
  late final SharedPreferences prefs;

  OnboardingViewModelProvider() {
    checkFresher();
    notifyListeners();
  }

  void scrollPage(double? currentPage) {
    _page = currentPage;
    notifyListeners();
  }

  checkFresher() async {
    isLoading = true;
    notifyListeners();
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFresher') ?? true) {
      isFresher = true;
    } else {
      isFresher = false;
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
   void gotoHome(BuildContext context) async {
      Navigator.pushNamed(context, RouteNames.loginScreen);

  }
}