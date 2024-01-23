import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/screens/pages/tab_pages/browers.dart';
import 'package:oweflow/screens/pages/tab_pages/lenders.dart';
import 'package:oweflow/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enjelin Morgeana',
                    style: GoogleFonts.inter(
                      color: colorwhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
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
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) => Noti()));
                        },
                        child: Image.asset("assets/noti.png",
                            height: 30, width: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 374,
                height: 201,
                decoration: ShapeDecoration(
                  color: Color(0xFF141326),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: GoogleFonts.inter(
                          color: colorwhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.32,
                        ),
                      ),
                      Text(
                        '\$ 2,548.00',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -1.50,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: colorwhite,
                                  ),
                                  Text(
                                    'Borrowers',
                                    style: GoogleFonts.inter(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      letterSpacing: -0.32,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '\$ 1,840.00',
                                style: GoogleFonts.inter(
                                  color: colorwhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -1,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: colorwhite,
                                  ),
                                  Text(
                                    'Lenders',
                                    style: GoogleFonts.inter(
                                      color: colorwhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      letterSpacing: -0.32,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '\$ 1,840.00',
                                style: GoogleFonts.inter(
                                  color: colorwhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -1,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: appBarColor,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TabBar(
                              indicatorColor: textColor,
                              labelColor: textColor,
                              tabs: [
                                Text(
                                  'Borrowers',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.40,
                                  ),
                                ),
                                Text(
                                  'Lenders',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.40,
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Borrowers(),
                      Lenders(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
