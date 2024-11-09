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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => Noti()));
              },
              icon: Icon(
                Icons.notifications,
                color: black,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => PremiumFeatures()));
            },
            icon: Icon(Icons.menu)),
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: StreamBuilder<Object>(
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
                Card(
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            document['firstName'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => PersonalProfile()));
                    },
                    leading: Image.asset(
                      "assets/accountinfo.png",
                      width: 35,
                      height: 30,
                    ),
                    title: Text(
                      'Account info',
                      style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: arrowColor,
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Noti()));
                    },
                    leading: Icon(
                      Icons.notifications,
                      color: arrowColor,
                    ),
                    title: Text(
                      'Notifications',
                      style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: arrowColor,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => PremiumFeatures()));
                    },
                    leading: Icon(
                      Icons.explicit_outlined,
                      color: arrowColor,
                    ),
                    title: Text(
                      'Premium Features',
                      style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: arrowColor,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: arrowColor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => SchedulesFeatures()));
                    },
                    leading: Icon(
                      Icons.schedule,
                      color: arrowColor,
                    ),
                    title: Text(
                      'Schedules',
                      style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                // ListTile(
                //   leading: Image.asset(
                //     "assets/mdi_dollar.png",
                //     width: 35,
                //     height: 30,
                //   ),
                //   title: Text(
                //     'Subscription',
                //     style: GoogleFonts.inter(
                //       color: black,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //       height: 0,
                //     ),
                //   ),
                // ),
                Card(
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: arrowColor,
                    ),
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
                                      style: GoogleFonts.plusJakartaSans(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
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
                                        style: GoogleFonts.plusJakartaSans(
                                          color: black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "SignOut Successfully")));
                                    },
                                    child: Container(
                                      width: 295,
                                      height: 48,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(-1.00, -0.03),
                                          end: Alignment(1, 0.03),
                                          colors: [buttonColor, buttonColor],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    height: 30,
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
                    leading: Icon(
                      Icons.logout,
                      color: arrowColor,
                    ),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
