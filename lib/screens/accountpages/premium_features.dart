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
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: colorwhite,
                    )),
                Text(
                  'Premium Features',
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Noti()));
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
                return Text(
                  document['firstName'] + " " + document['lastName'],
                  style: GoogleFonts.inter(
                    color: colorwhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => FinancialGoals()));
            },
            leading: Image.asset(
              "assets/mdi_finance.png",
              width: 35,
              height: 30,
            ),
            title: Text(
              'Financial Goals',
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
                  MaterialPageRoute(builder: (builder) => BudgetTracking()));
            },
            leading: Image.asset(
              "assets/fluent_eye-tracking-20-filled.png",
              width: 35,
              height: 30,
            ),
            title: Text(
              'Budget  Tracking',
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
                  MaterialPageRoute(builder: (builder) => CurrencyExchange()));
            },
            leading: Image.asset(
              "assets/mdi_dollar.png",
              width: 35,
              height: 30,
            ),
            title: Text(
              'Currency Exchange',
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
                  MaterialPageRoute(builder: (builder) => CurrencyExchange()));
            },
            leading: Image.asset(
              "assets/shield-checkered-fill 1.png",
              width: 35,
              height: 30,
            ),
            title: Text(
              'Reports',
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
                  MaterialPageRoute(builder: (builder) => PremiumFeatures()));
            },
            leading: Image.asset(
              "assets/lock-key-fill 1.png",
              width: 35,
              height: 30,
            ),
            title: Text(
              'Mode Customization',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
