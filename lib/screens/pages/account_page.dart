import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/screens/accountpages/personalprofile.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/screens/accountpages/schedueles_features.dart';
import 'package:oweflow/screens/auth/sign_in_page.dart';
import 'package:oweflow/utils/colors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/back.png",
              ),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high)),
      child: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            var document = snapshot.data;
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Settings',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: colorwhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => Noti()));
                            },
                            child: Image.asset(
                              "assets/noti.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => PremiumFeatures()));
                            },
                            child: Image.asset(
                              "assets/menu.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  document['firstName'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: colorwhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Text(
                  document['lastName'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: colorwhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/accountinfo.png",
                    width: 35,
                    height: 30,
                  ),
                  title: Text(
                    'Account info',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => PersonalProfile()));
                  },
                  leading: Image.asset(
                    "assets/personal.png",
                    width: 35,
                    height: 30,
                  ),
                  title: Text(
                    'Personal Profile',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Noti()));
                  },
                  leading: Image.asset(
                    "assets/Vector.png",
                    width: 35,
                    height: 30,
                  ),
                  title: Text(
                    'Notifications',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Logout',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF242424),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 231,
                                    child: Text(
                                      'Are you sure you want to Logout your account?',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF7B7F91),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                SignInPage()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("SignOut Successfully")));
                                  },
                                  child: Container(
                                    width: 295,
                                    height: 48,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-1.00, -0.03),
                                        end: Alignment(1, 0.03),
                                        colors: [
                                          Color(0xFF823DD8),
                                          Color(0xFFE84040),
                                          Color(0xFFF80354)
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Logout',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: colorwhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 0.10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Not Now',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0.10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  leading: Image.asset(
                    "assets/shield-checkered-fill 1.png",
                    width: 35,
                    height: 30,
                  ),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => PremiumFeatures()));
                  },
                  leading: Image.asset(
                    "assets/lock-key-fill 1.png",
                    width: 35,
                    height: 30,
                  ),
                  title: Text(
                    'Premium Features',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SchedulesFeatures()));
                  },
                  leading: Image.asset(
                    "assets/lock-key-fill 1.png",
                    width: 35,
                    height: 30,
                  ),
                  title: Text(
                    'Schedules',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/mdi_dollar.png",
                    width: 35,
                    height: 30,
                  ),
                  title: Text(
                    'Subscription',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                )
              ],
            );
          }),
    ));
  }
}
