import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/featuers/offline_finanical_goals.dart';
import 'package:oweflow/screens/accountpages/currency_exchange.dart';

import 'package:oweflow/utils/colors.dart';

class PremiumFeaturesOffline extends StatefulWidget {
  const PremiumFeaturesOffline({super.key});

  @override
  State<PremiumFeaturesOffline> createState() => _PremiumFeaturesOfflineState();
}

class _PremiumFeaturesOfflineState extends State<PremiumFeaturesOffline> {
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
                          builder: (builder) => FinancialGoalsOffline()));
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
