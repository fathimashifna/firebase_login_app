import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../res/widgets/app_colors.dart';
import '../viewmodel/registration_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isloading = false;
  TextEditingController? _name;
  TextEditingController? _email;
  TextEditingController? _password;
  final _focusEmail = FocusNode();
  final _focusName = FocusNode();
  final _focusPassword = FocusNode();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }
  final RegistrationViewModel _regViewModel = RegistrationViewModel();

  Widget textView(
      String text, double fontsize, Color color, FontWeight fontWeight) {
    return Text(text,
        style: GoogleFonts.inter(
            fontSize: fontsize, color: color, fontWeight: fontWeight));
  }

  Widget _nameField() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20.0, left: 25.0),
          alignment: Alignment.centerLeft,
          child: textView('Full Name', 14.0, Colors.black, FontWeight.w400),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.055,
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: TextFormField(
              controller: _name,
                focusNode: _focusName,
                style: GoogleFonts.inter(
                    fontSize: 14.0, color: AppColors.color_text),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Enter full name'),
                  LengthRangeValidator(errorText: 'Please enter a name min 3 character', min: 3, max: 25),
                ]).call,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10,bottom: 20),
                    errorStyle: GoogleFonts.inter(
                        fontSize: 14.0, color: AppColors.color_text),))),
      ],
    );
  }
  Widget _emailField() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20.0, left: 25.0),
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
                    contentPadding: const EdgeInsets.only(left: 10,bottom: 20),
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
          child: textView('Set Password', 14.0, Colors.black, FontWeight.w400),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.055,
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: TextFormField(
                controller: _password,
                focusNode: _focusPassword,
                obscureText: _isObscure,
                style: GoogleFonts.inter(
                    fontSize: 14.0, color: AppColors.color_text),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please enter Password'),
                  MinLengthValidator(8,
                      errorText: 'Password must be at least 8 digit'),
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
                        fontSize: 14.0, color: AppColors.color_text),))),
      ],
    );
  }



  Widget _registerButton() {
    return _isloading ? Center(
      child: CircularProgressIndicator(),
    ):Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              _focusEmail.unfocus();
              _focusName.unfocus();
              _focusPassword.unfocus();
              _regViewModel.signUp(_name!.text.toString(),_email!.text.toString(), _password!.text.toString(), context);
              _name!.clear();
              _email!.clear();
              _password!.clear();

            }
          },
          style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              backgroundColor: WidgetStateProperty.all<Color>( AppColors.color_primary),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.color_primary)
                  )
              )
          ),
          child:  Text(
            'Register',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _name!.dispose();
    _email!.dispose();
    _password!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: Image.asset('assets/images/sample_image.png'),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.71,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: const ImageIcon(AssetImage('assets/images/arrow_left.png'))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,left: 25.0),
                            child: textView(
                                'SignUp', 24, Colors.black, FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0,left: 25.0),
                            child: Text.rich(TextSpan(
                                text: 'Already have an account? ',
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.color_text),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Login',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.color_primary),
                                  )
                                ])),
                          ),
                          Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _nameField(),
                                  _emailField(),
                                  _passwordField(),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Consumer<RegistrationViewModel>(
                                      builder: (context, value, c) {
                                        //print('is loading${value.isloading}');
                                        return _registerButton();
                                      }),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
