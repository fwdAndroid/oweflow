import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/featuers/add_goals_offline.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class FinancialGoalsOffline extends StatefulWidget {
  const FinancialGoalsOffline({super.key});

  @override
  State<FinancialGoalsOffline> createState() => _FinancialGoalsOfflineState();
}

class _FinancialGoalsOfflineState extends State<FinancialGoalsOffline> {
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
            "Financial Goals",
            style: GoogleFonts.plusJakartaSans(
                color: black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListTile(
            //     title: Text(
            //       'August 2022',
            //       style: GoogleFonts.dmSans(
            //         color: black,
            //         fontSize: 14,
            //         fontWeight: FontWeight.w400,
            //         height: 0.14,
            //         letterSpacing: 0.42,
            //       ),
            //     ),
            //     subtitle: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           '\$47,297',
            //           style: GoogleFonts.dmSans(
            //             color: b,
            //             fontSize: 42,
            //             fontWeight: FontWeight.w700,
            //           ),
            //         ),
            //         ElevatedButton(
            //           onPressed: () {},
            //           child: Text(
            //             "Month",
            //             style: TextStyle(color: black),
            //           ),
            //           style: ElevatedButton.styleFrom(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             backgroundColor: textColor,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
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
                      color: black,
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
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Text(
                            " data['amount']",
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.w600),
                          ),
                          title: Text(
                            " data['name']",
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "data['date']",
                            style: TextStyle(fontWeight: FontWeight.w600),
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
                                            style: TextStyle(color: black),
                                          )
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            // await FirebaseFirestore
                                            //     .instance
                                            //     .collection(
                                            //         "goals")
                                            //     .doc(data['uuid'])
                                            //     .delete();
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder:
                                            //             (builder) =>
                                            //                 MainDashboard()));
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
                          color: black.withOpacity(.2),
                        )
                      ],
                    );
                  })),
            ),
            Flexible(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AddGoalsOffline()));
                  },
                  title: "Add New Goals"),
            )
          ],
        ));
  }
}
