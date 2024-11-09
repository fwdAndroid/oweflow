import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
import 'package:oweflow/offline_mode/schedule/schedule_features_offline.dart';
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
                          builder: (builder) => ScheduleFeaturesOffline()));
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
          ],
        ));
  }
}
