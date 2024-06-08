import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
import 'package:oweflow/screens/accountpages/schedueles_features.dart';
import 'package:oweflow/selection_screen.dart';
import 'package:oweflow/utils/colors.dart';

class AccountPageOffline extends StatefulWidget {
  const AccountPageOffline({super.key});

  @override
  State<AccountPageOffline> createState() => _AccountPageOfflineState();
}

class _AccountPageOfflineState extends State<AccountPageOffline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => PremiumFeaturesOffline()));
              },
              icon: Icon(Icons.menu)),
          centerTitle: true,
          title: Text(
            "Settings",
            style: GoogleFonts.plusJakartaSans(
                color: black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => PremiumFeaturesOffline()));
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              SelectionScreen()));
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
                                      colors: [buttonColor, buttonColor],
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
        ));
  }
}
