import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/personalprofile.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Debits Details
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/Card.png",
                    height: 90,
                    width: 90,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Image.asset(
                    "assets/Card (1).png",
                    height: 90,
                    width: 90,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Image.asset(
                    "assets/Card (2).png",
                    height: 90,
                    width: 90,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Image.asset(
                    "assets/Card (3).png",
                    height: 90,
                    width: 90,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Last Transactions',
              style: GoogleFonts.inter(
                color: black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 0,
                letterSpacing: -0.40,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.4,
            child: StreamBuilder(
              stream: getContactsStream(),
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
                    Color amountColor = isReceived ? Colors.green : Colors.red;
                    String message = isReceived ? "You Borrowed" : "You Lent";

                    return Card(
                      elevation: 1,
                      color: colorwhite,
                      child: ListTile(
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Functions
  // Contact List
  Stream<QuerySnapshot> getContactsStream() {
    return FirebaseFirestore.instance
        .collection("debitTransaction")
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // Number of Debitors
  docss() async {
    AggregateQuerySnapshot query = await FirebaseFirestore.instance
        .collection('debitTransaction')
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .count()
        .get();

    int numberOfDocuments = query.count;
    return numberOfDocuments;
  }

  // Total Amount
  Future<void> calculateTotalAmount() async {
    // Query Firestore to calculate total amount
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('debitTransaction') // Replace with your collection name
          .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
