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
  bool isLoading = false;

  TextEditingController _passwordController = TextEditingController();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Forgot Password',
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
                'Enter your email account to reset your \npassword',
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
              controller: _passwordController,
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
                  hintText: "youremail@email.abc",
                  hintStyle:
                      GoogleFonts.plusJakartaSans(color: black, fontSize: 12)),
            ),
          ),
          Flexible(child: Container()),
          Flexible(child: Container()),
          Flexible(child: Container()),
          Flexible(child: Container()),
          SaveButton(
              title: "Send",
              onTap: () async {
                if (_passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Email is Required To reset the password")));
                } else {
                  setState(() {
                    isLoading = true;
                  });

                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _passwordController.text.trim());

                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Reset Password Link Send to your email")));
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: SingleChildScrollView(
                              child: ListBody(children: <Widget>[
                        Image.asset(
                          "assets/mail.png",
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: SizedBox(
                            width: 231,
                            child: Text(
                              'Check your email',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: SizedBox(
                            width: 231,
                            child: Text(
                              'We have send a password recover \nintruction to your email',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => SignInPage()));
                          },
                          child: Center(
                            child: Text(
                              'Close',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ])));
                    },
                  );
                }
              }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
