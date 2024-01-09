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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
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
        child: SingleChildScrollView(
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
                  controller: _nameController,
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
                      hintText: "First Name",
                      hintStyle:
                          GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _lastNameController,
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
                      hintText: "Last Name",
                      hintStyle:
                          GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
                ),
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
                      hintText: "Email Address",
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
                      hintText: "Password (Minimum 6 Characters)",
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
                      hintText: "Confirm Password",
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
                      title: "Continue",
                      onTap: () async {
                        if (_nameController.text.isEmpty ||
                            _lastNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "First Name and Last Name is Required")));
                        } else if (_emailController.text.isEmpty ||
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
                            firstName: _nameController.text,
                            lastName: _lastNameController.text);

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
                        text: 'Already have an account? ',
                        style: GoogleFonts.dmSans(
                          color: colorwhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign I',
                        style: GoogleFonts.dmSans(
                          color: colorwhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'n\n',
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
            ],
          ),
        ),
      ),
    );
  }
}
