import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/auth/sign_in_page.dart';
import 'package:oweflow/screens/main_dashboard.dart';
import 'package:oweflow/services/auth.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class SignUpAccount extends StatefulWidget {
  const SignUpAccount({super.key});

  @override
  State<SignUpAccount> createState() => _SignUpAccountState();
}

class _SignUpAccountState extends State<SignUpAccount> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            )),
      ),
      backgroundColor: colorwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Register',
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w600, fontSize: 32),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Create your account',
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
                      color: black, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.dmSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Email Address",
                    hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Password',
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                obscureText: _obscureText,
                controller: _passwordController,
                style: GoogleFonts.dmSans(color: black),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
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
                    hintText: "Password",
                    hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : SaveButton(
                    title: "Register",
                    onTap: () async {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Email or Password is Required")));
                      } else {
                        setState(() {
                          _isLoading = true;
                        });
                      }

                      String res = await AuthMethods().signUpUser(
                          email: _emailController.text,
                          password: _passwordController.text,
                          confrimPassword: _passwordController.text,
                          firstName: "",
                          lastName: "");

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
                    }),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => SignInPage()));
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "I have an account ? ",
                      style: GoogleFonts.plusJakartaSans(
                        color: Color(0xff7E94B4),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Log in',
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
          ],
        ),
      ),
    );
  }
}
