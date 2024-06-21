import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/personalprofile.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/utils/colors.dart';

class Borrowers extends StatefulWidget {
  const Borrowers({super.key});

  @override
  State<Borrowers> createState() => _BorrowersState();
}

class _BorrowersState extends State<Borrowers> {
  var totalAmount = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => PersonalProfile()));
              },
              icon: Icon(
                Icons.settings,
                color: black,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => PremiumFeatures()));
            },
            icon: Icon(
              Icons.menu,
              color: black,
            )),
        centerTitle: true,
        title: Text(
          "Home",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
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
                      '\$$totalAmount',
                      style: GoogleFonts.inter(
                        color: Colors.white,
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("debitTransaction")
                    .where("userID",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("status", isEqualTo: "Received")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No Debtors Details Available",
                        style: TextStyle(color: black),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        final Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;

                        // Determine color and message based on transaction status
                        bool isReceived = data['status'] == 'Received';
                        Color amountColor =
                            isReceived ? Colors.green : Colors.red;
                        String message =
                            isReceived ? "You Borrowed" : "You Lent";

                        return Column(
                          children: [
                            ListTile(
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    message,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: amountColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "\$" + data['amount'].toString(),
                                    style: GoogleFonts.plusJakartaSans(
                                      color: amountColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  // IconButton(
                                  //   onPressed: () {
                                  //     showDialog<void>(
                                  //       context: context,
                                  //       barrierDismissible:
                                  //           false, // user must tap button!
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //           title: const Text('Debt Information'),
                                  //           content: SingleChildScrollView(
                                  //             child: ListTile(
                                  //               title: Text(
                                  //                 data['contact'],
                                  //                 style: TextStyle(color: black),
                                  //               ),
                                  //               subtitle: Text(
                                  //                 data['date'],
                                  //                 style: TextStyle(color: black),
                                  //               ),
                                  //               trailing: Text(
                                  //                 '${data['amount'].toString()}\$',
                                  //                 style: TextStyle(color: black),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           actions: <Widget>[
                                  //             TextButton(
                                  //               child: const Text('Done'),
                                  //               onPressed: () async {
                                  //                 print("object");
                                  //                 await FirebaseFirestore.instance
                                  //                     .collection("closedTransaction")
                                  //                     .doc(data['uuid'])
                                  //                     .set(
                                  //                   {
                                  //                     "status": "closed",
                                  //                     "amount": 0,
                                  //                     "notes": data['notes'],
                                  //                     "userID": data['userID'],
                                  //                     "uuid": data['uuid'],
                                  //                     "contact": data['contact'],
                                  //                     "date": data['date']
                                  //                   },
                                  //                 );
                                  //                 await FirebaseFirestore.instance
                                  //                     .collection("debitTransaction")
                                  //                     .doc(data['uuid'])
                                  //                     .delete();
                                  //                 Navigator.of(context).pop();
                                  //               },
                                  //             ),
                                  //             TextButton(
                                  //               child: const Text('Close'),
                                  //               onPressed: () {
                                  //                 Navigator.of(context).pop();
                                  //               },
                                  //             ),
                                  //           ],
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.check,
                                  //     color: g,
                                  //   ),
                                  // ),
                                ],
                              ),
                              title: Text(
                                data['contact'],
                                style: GoogleFonts.plusJakartaSans(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['notes'],
                                    style: GoogleFonts.plusJakartaSans(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    data['date'],
                                    style: GoogleFonts.plusJakartaSans(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }

  Future<void> calculateTotalAmount() async {
    // Query Firestore to calculate total amount
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('debitTransaction') // Replace with your collection name
          .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: 'Received')
          .get();

      double total = 0.0;

      querySnapshot.docs.forEach((doc) {
        total +=
            (doc['amount'] ?? 0.0); // Replace 'amount' with your field name
      });

      setState(() {
        totalAmount = total.toInt();
      });
    } catch (e) {
      print('Error calculating total amount: $e');
    }
  }
}
