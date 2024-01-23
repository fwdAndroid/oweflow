import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/screens/main_dashboard.dart';
import 'package:oweflow/screens/premiumfeatues/goals/add_goals.dart';
import 'package:oweflow/utils/colors.dart';

class FinancialGoals extends StatefulWidget {
  const FinancialGoals({super.key});

  @override
  State<FinancialGoals> createState() => _FinancialGoalsState();
}

class _FinancialGoalsState extends State<FinancialGoals> {
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
                  'Financial Goals',
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
            child: ListTile(
              title: Text(
                'August 2022',
                style: GoogleFonts.dmSans(
                  color: colorwhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: 0.42,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$47,297',
                    style: GoogleFonts.dmSans(
                      color: b,
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Month",
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
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget list',
                  style: GoogleFonts.dmSans(
                    color: colorwhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
                Text(
                  'Manage',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFFE84040),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("goals")
                      .where("uid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Goals Found yet",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance
                                  .collection("goals")
                                  .where("uid",
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                final Map<String, dynamic> data =
                                    documents[index].data()
                                        as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Text(
                                        "\$" + data['amount'],
                                        style: TextStyle(
                                            color: colorwhite,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      title: Text(
                                        data['name'],
                                        style: TextStyle(
                                            color: colorwhite,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        data['date'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Delete Alert'),
                                                  content: Column(
                                                    children: [
                                                      Text(
                                                        "Do you want to delete the goal ?",
                                                        style: TextStyle(
                                                            color: colorwhite),
                                                      )
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("goals")
                                                            .doc(data['uuid'])
                                                            .delete();
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (builder) =>
                                                                        MainDashboard()));
                                                      },
                                                      child: Text('Yes'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ),
                                    Divider(
                                      color: colorwhite.withOpacity(.2),
                                    )
                                  ],
                                );
                              });
                        });
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => AddGoals()));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/btn.png"),
            ),
          )
        ],
      ),
    ));
  }
}
