import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/utils/colors.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
                  Text(
                    'Transaction Details',
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
              height: 20,
            ),
            Text(
              'Total Balance',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: colorwhite,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            Text(
              '\$ 2,548.00',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: colorwhite,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                height: 0,
                letterSpacing: -1.50,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Transaction Detail",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: c,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),
                  Image.asset(
                    "assets/calendar.png",
                    height: 35,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.9,
                child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage("assets/splash.png"),
                            ),
                            trailing: Text(
                              '500\$',
                              style: GoogleFonts.lato(
                                color: colorwhite,
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            title: Text(
                              'Subodh Kolhe',
                              style: GoogleFonts.lato(
                                color: colorwhite,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            subtitle: Text(
                              'You owe',
                              style: GoogleFonts.lato(
                                color: colorwhite,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
