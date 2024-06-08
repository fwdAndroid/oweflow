import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
import 'package:oweflow/utils/colors.dart';

class WalletPageOffline extends StatefulWidget {
  const WalletPageOffline({super.key});

  @override
  State<WalletPageOffline> createState() => _WalletPageOfflineState();
}

class _WalletPageOfflineState extends State<WalletPageOffline> {
  var totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //calculateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => PremiumFeaturesOffline()));
                },
                icon: Icon(
                  Icons.menu,
                  color: black,
                )),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(
            "Transaction Details",
            style: GoogleFonts.plusJakartaSans(
                color: black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 374,
              height: 120,
              decoration: ShapeDecoration(
                color: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Current Balance',
                      style: GoogleFonts.plusJakartaSans(
                        color: colorwhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '"Total Amount"',
                      style: GoogleFonts.inter(
                        color: colorwhite,
                        fontSize: 46,
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -1.50,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Current Transactions",
            style: GoogleFonts.inter(
              color: colorwhite,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      //String contactNames = data['contact'].join(', ');
                      return Column(
                        children: [
                          ListTile(
                              title: Text(
                                'Name: "Contact Names"',
                                style: TextStyle(color: black),
                              ),
                              subtitle: Text(
                                "Amount",
                                style: TextStyle(color: black),
                              ),
                              // Add more fields as needed
                              trailing: Text(
                                " data['status']",
                                style: TextStyle(color: g),
                              )),
                          Divider()
                        ],
                      );
                    },
                  ))),

          //Closed
          Text(
            "Closed Transactions",
            style: GoogleFonts.inter(
              color: colorwhite,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                              title: Text(
                                'Name',
                                style: TextStyle(color: black),
                              ),
                              subtitle: Text(
                                'Amount',
                                style: TextStyle(color: black),
                              ),
                              // Add more fields as needed
                              trailing: Text(
                                " data['status']",
                                style: TextStyle(color: g),
                              )),
                          Divider()
                        ],
                      );
                    },
                  )))
        ]));
  }
}
