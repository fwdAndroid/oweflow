import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/auth/sign_in_page.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLoading = false;

  TextEditingController _passwordController = TextEditingController();
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/uiux logos 1.png",
              height: 300,
              width: 200,
              fit: BoxFit.cover,
            ),
            Flexible(child: Container()),
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
                    hintText: "Enter Your Email Address To Regenerate Password",
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SaveButton(
                title: "Send",
                onTap: () async {
                  if (_passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Email is Required To reset the password")));
                  } else {
                    setState(() {
                      _isLoading = true;
                    });

                    await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: _passwordController.text.trim());

                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Reset Password Link Send to your email")));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SignInPage()));
                  }
                }),
            Flexible(child: Container()),
            Flexible(child: Container()),
            Flexible(child: Container()),
            Flexible(child: Container()),
          ],
        ),
      ),
    );
  }
}
