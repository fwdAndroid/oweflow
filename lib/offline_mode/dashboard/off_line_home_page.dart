import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';

import 'package:oweflow/utils/colors.dart';

class OfflineHomePage extends StatefulWidget {
  const OfflineHomePage({super.key});

  @override
  State<OfflineHomePage> createState() => _OfflineHomePageState();
}

class _OfflineHomePageState extends State<OfflineHomePage> {
  var totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // calculateTotalAmount();
  }

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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //Debits Detals
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Transactions',
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
              height: MediaQuery.of(context).size.height / 2.3,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  //String contactNames = data['contact'].join(', ');
                  return Card(
                    elevation: 1,
                    color: colorwhite,
                    child: ListTile(
                      title: Text(
                        'Total Contact Names',
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
                            "data['notes']",
                            style: GoogleFonts.plusJakartaSans(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "data['date']",
                            style: GoogleFonts.plusJakartaSans(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // Add more fields as needed
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Amount",
                            style: GoogleFonts.plusJakartaSans(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Debt Information'),
                                      content: SingleChildScrollView(
                                        child: ListTile(
                                          title: Text(
                                            "contactNames.toString()",
                                            style: TextStyle(color: black),
                                          ),
                                          subtitle: Text(
                                            " data['date']",
                                            style: TextStyle(color: black),
                                          ),
                                          trailing: Text(
                                            "Total AMount",
                                            style: TextStyle(color: black),
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Done'),
                                          onPressed: () async {
                                            print("object");
                                            // await FirebaseFirestore.instance
                                            //     .collection(
                                            //         "closedTransaction")
                                            //     .doc(data['uuid'])
                                            //     .set(
                                            //   {
                                            //     "status": "closed",
                                            //     "amount": 0,
                                            //     "notes": data['notes'],
                                            //     "userID": data['userID'],
                                            //     "uuid": data['uuid'],
                                            //     "contact": contactNames,
                                            //     "date": data['date']
                                            //   },
                                            // );
                                            // await FirebaseFirestore.instance
                                            //     .collection(
                                            //         "debitTransaction")
                                            //     .doc(data['uuid'])
                                            //     .delete();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.check,
                                color: g,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ))
        ]));
  }
}

// //Functions
//   //Contact List
//   Stream<QuerySnapshot> getContactsStream() {
//     return FirebaseFirestore.instance
//         .collection("debitTransaction")
//         .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .snapshots();
//   }

//   //Number of Debitors
//   docss() async {
//     AggregateQuerySnapshot query = await FirebaseFirestore.instance
//         .collection('debitTransaction')
//         .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .count()
//         .get();

//     int numberOfDocuments = query.count;
//     return numberOfDocuments;
//   }

//   //Total Amount
//   Future<void> calculateTotalAmount() async {
//     // Query Firestore to calculate total amount
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('debitTransaction') // Replace with your collection name
//           .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       double total = 0.0;

//       querySnapshot.docs.forEach((doc) {
//         total +=
//             (doc['amount'] ?? 0.0); // Replace 'amount' with your field name
//       });

//       setState(() {
//         totalAmount = total.toInt();
//       });
//     } catch (e) {
//       print('Error calculating total amount: $e');
//     }
//   }
// }


//Total Borrows
// Column(
//                       children: [
//                         Text(
//                           'Total Borrowers',
//                           style: GoogleFonts.inter(
//                             color: textColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             height: 0,
//                             letterSpacing: -0.32,
//                           ),
//                         ),
//                       ],
//                     ),
