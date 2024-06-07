import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/currency_exchange.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/screens/premiumfeatues/budget_tracking.dart';
import 'package:oweflow/screens/premiumfeatues/financialgoals.dart';
import 'package:oweflow/utils/colors.dart';

class PremiumFeatures extends StatefulWidget {
  const PremiumFeatures({super.key});

  @override
  State<PremiumFeatures> createState() => _PremiumFeaturesState();
}

class _PremiumFeaturesState extends State<PremiumFeatures> {
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
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: black,
              )),
          centerTitle: true,
          title: Text(
            "Premium Features",
            style: GoogleFonts.plusJakartaSans(
                color: black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<Object>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return new CircularProgressIndicator();
                  }
                  var document = snapshot.data;
                  return Card(
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
                  );
                }),
            const SizedBox(
              height: 30,
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                trailing: Icon(
                  Icons.arrow_forward,
                  color: arrowColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => FinancialGoals()));
                },
                leading: Image.asset(
                  "assets/mdi_finance.png",
                  width: 35,
                  height: 30,
                ),
                title: Text(
                  'Financial Goals',
                  style: GoogleFonts.plusJakartaSans(
                    color: black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => BudgetTracking()));
                },
                leading: Image.asset(
                  "assets/fluent_eye-tracking-20-filled.png",
                  width: 35,
                  height: 30,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: arrowColor,
                ),
                title: Text(
                  'Budget  Tracking',
                  style: GoogleFonts.plusJakartaSans(
                    color: black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                trailing: Icon(
                  Icons.arrow_forward,
                  color: arrowColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => CurrencyExchange()));
                },
                leading: Image.asset(
                  "assets/mdi_dollar.png",
                  width: 35,
                  height: 30,
                ),
                title: Text(
                  'Currency Exchange',
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
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (builder) => CurrencyExchange()));
            //   },
            //   leading: Image.asset(
            //     "assets/shield-checkered-fill 1.png",
            //     width: 35,
            //     height: 30,
            //   ),
            //   title: Text(
            //     'Reports',
            //     style: GoogleFonts.inter(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //       height: 0,
            //     ),
            //   ),
            // ),
            // Card(
            //   child: ListTile(
            //     trailing: Icon(
            //       Icons.arrow_forward,
            //       color: arrowColor,
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (builder) => PremiumFeatures()));
            //     },
            //     leading: Image.asset(
            //       "assets/lock-key-fill 1.png",
            //       width: 35,
            //       height: 30,
            //     ),
            //     title: Text(
            //       'Mode Customization',
            //       style: GoogleFonts.plusJakartaSans(
            //         color: black,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w500,
            //         height: 0,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
