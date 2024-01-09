import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/utils/colors.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => PremiumFeatures()));
              },
              child: Image.asset(
                "assets/menu.png",
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Statistics',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        elevation: 0,
        backgroundColor: appBarColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/splash.png",
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/Group 239007.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Spending',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.change_circle,
                    color: textColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/splash.png"),
                          ),
                          trailing: Text(
                            '- \$ 150.00',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                              color: red,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.72,
                            ),
                          ),
                          title: Text(
                            'Lenders',
                            style: GoogleFonts.lato(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          subtitle: Text(
                            'Jan 12, 2022',
                            style: GoogleFonts.lato(
                              color: borderColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
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
