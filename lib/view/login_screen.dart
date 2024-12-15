import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_login/insta_view.dart';
import 'package:provider/provider.dart';
import 'package:test_project/view/home_screen.dart';
import 'package:test_project/view/register_screen.dart';
import 'package:test_project/viewmodel/login_view_model.dart';

import '../res/widgets/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController? _email;
  TextEditingController? _password;
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _isLoading = _loginViewModel.isloading;
  }

  final LoginViewModel _loginViewModel = LoginViewModel();

  Widget textView(
      String text, double fontsize, Color color, FontWeight fontWeight) {
    return Text(text,
        style: GoogleFonts.inter(
            fontSize: fontsize, color: color, fontWeight: fontWeight));
  }

  Widget _emailField() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16.0, left: 25.0),
          alignment: Alignment.centerLeft,
          child: textView('Email', 14.0, Colors.black, FontWeight.w400),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.055,
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: TextFormField(
                controller: _email,
                focusNode: _focusEmail,
                style: GoogleFonts.inter(
                    fontSize: 14.0, color: AppColors.color_text),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Enter email address'),
                  EmailValidator(errorText: 'Please correct email filled'),
                ]).call,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10,bottom: 18),
                    errorStyle: GoogleFonts.inter(
                        fontSize: 14.0, color: AppColors.color_text)))),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16.0, left: 25.0),
          alignment: Alignment.centerLeft,
          child: textView('Password', 14.0, Colors.black, FontWeight.w400),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.055,
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: TextFormField(
                controller: _password,
                obscureText: _isObscure,
                focusNode: _focusPassword,
                style: GoogleFonts.inter(
                    fontSize: 14.0, color: AppColors.color_text),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please enter Password'),
                  MinLengthValidator(8,
                      errorText: 'Password must be atlist 8 digit'),
                  PatternValidator(r'(?=.*?[#!@$%^&*-])',
                      errorText:
                          'Password must be at least one special character')
                ]).call,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    errorStyle: GoogleFonts.inter(
                        fontSize: 14.0, color: AppColors.color_text)))),
      ],
    );
  }

  Widget _forgotPass() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: textView(
          'Forgot Password ?', 12.0, AppColors.color_primary, FontWeight.w500),
    );
  }

  Widget _loginButton(LoginViewModel value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          onPressed: () async {
            _focusEmail.unfocus();
            _focusPassword.unfocus();

            if (_formkey.currentState!.validate()) {
              _loginViewModel.signIn(_email!.text.toString(), _password!.text.toString(), context);
              _email!.clear();
              _password!.clear();

            }
          },
          style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              backgroundColor:
              WidgetStateProperty.all<Color>(AppColors.color_primary),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.color_primary)))),
          child: Text(
            'Login',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }

  Widget _signInUsing() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 9.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const Divider()),
              textView('OR', 10.0, AppColors.color_text, FontWeight.normal),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const Divider()),
            ],
          ),
          GestureDetector(
            onTap: (){
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 18.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.46),
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        'assets/images/instagram.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    textView('Continue with Instagram', 12, AppColors.color_text,
                        FontWeight.normal)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _email!.dispose();
    _password!.dispose();
    super.dispose();
  }
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
              future:_initializeFirebase(),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/app_bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 30.0, bottom: 30.0),
                          child: Image.asset('assets/images/sample_image.png'),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          margin:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: textView(
                                    'Login', 24, Colors.black, FontWeight.w700),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                          const RegisterScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: Text.rich(TextSpan(
                                      text: 'Don’t have an account? ',
                                      style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.color_text),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: 'SignUp',
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.color_primary),
                                        )
                                      ])),
                                ),
                              ),
                              Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      _emailField(),
                                      _passwordField(),
                                      _forgotPass(),
                                      Consumer<LoginViewModel>(
                                          builder: (context, value, c) {
                                            //print('is loading${value.isloading}');
                                            return _loginButton(value);
                                          }),
                                      //_signInUsing()
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
