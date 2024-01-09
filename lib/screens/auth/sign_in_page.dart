import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/splash.png",
                ),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/uiux logos 1.png",
              height: 300,
              width: 200,
              fit: BoxFit.cover,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _emailController,
                style: GoogleFonts.dmSans(color: colorwhite),
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
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _passwordController,
                style: GoogleFonts.dmSans(color: colorwhite),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Enter Password",
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Email or Password is Required")));
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
                        style: GoogleFonts.dmSans(
                            color: colorwhite,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            Flexible(child: Container()),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => SignUpAccount()));
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.dmSans(
                        color: colorwhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: GoogleFonts.dmSans(
                        color: colorwhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
