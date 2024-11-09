import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/auth/sign_up_account.dart';
import 'package:oweflow/screens/forgot/forgot_password.dart';
import 'package:oweflow/screens/main_dashboard.dart';
import 'package:oweflow/services/auth.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          backgroundColor: colorwhite,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Sign in to your Account',
                        style: GoogleFonts.plusJakartaSans(
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Sign in to your Account',
                        style: GoogleFonts.plusJakartaSans(
                            color: Color(0xff7E94B4),
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Your Email',
                        style: GoogleFonts.plusJakartaSans(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _emailController,
                      style: GoogleFonts.plusJakartaSans(color: black),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          hintText: "Enter Email Address",
                          hintStyle: GoogleFonts.plusJakartaSans(
                              color: black, fontSize: 12)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 16),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Password',
                        style: GoogleFonts.plusJakartaSans(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: _passwordController,
                      style: GoogleFonts.plusJakartaSans(color: black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor)),
                          hintText: "Enter Password",
                          hintStyle: GoogleFonts.plusJakartaSans(
                              color: black, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : SaveButton(
                          title: "Login",
                          onTap: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Email or Password is Required")));
                            } else {
                              setState(() {
                                _isLoading = true;
                              });

                              String res = await AuthMethods().loginUpUser(
                                email: _emailController.text,
                                pass: _passwordController.text,
                              );

                              setState(() {
                                _isLoading = false;
                              });
                              if (res != 'sucess') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(res)));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => MainDashboard()));
                              }
                            }
                          }),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 25),
                      child: SizedBox(
                        width: 154,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ForgotPassword()));
                            },
                            child: Text(
                              "Forgot Password",
                              style: GoogleFonts.plusJakartaSans(
                                color: buttonColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SignUpAccount()));
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.plusJakartaSans(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'Register',
                              style: GoogleFonts.plusJakartaSans(
                                color: buttonColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop(); // For Android
              } else if (Platform.isIOS) {
                exit(0); // For iOS
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
