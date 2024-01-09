import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/utils/colors.dart';

class BudgetTracking extends StatefulWidget {
  const BudgetTracking({super.key});

  @override
  State<BudgetTracking> createState() => _BudgetTrackingState();
}

class _BudgetTrackingState extends State<BudgetTracking> {
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
                  'Budget Tracking',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Records',
                  style: GoogleFonts.dmSans(
                    color: colorwhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Year",
                    style: TextStyle(color: colorwhite),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: textColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Image.asset(
                "assets/green.png",
                height: 76,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/re.png"),
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Monthly stats',
                style: GoogleFonts.dmSans(
                  color: colorwhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                  letterSpacing: 0.48,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 98,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 178,
                      height: 98,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: colorwhite,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0x33E84040)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 92,
                                        height: 18,
                                        child: Text(
                                          'August savings',
                                          style: GoogleFonts.dmSans(
                                            color: black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '\$18,836.00',
                                  style: GoogleFonts.dmSans(
                                    color: b,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 0.09,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: ShapeDecoration(
                                            color: b,
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 1),
                                Text(
                                  '+12%',
                                  style: TextStyle(
                                    color: b,
                                    fontSize: 11,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0.12,
                                  ),
                                ),
                                const SizedBox(width: 1),
                                Text(
                                  'more than May',
                                  style: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.800000011920929),
                                    fontSize: 11,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0.12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
