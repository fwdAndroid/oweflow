import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => Debtors();
}

class Debtors extends State<HomePage> {
  var totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateTotalAmount();
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<Object>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return new CircularProgressIndicator();
                  }
                  var document = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          document['firstName'] + " " + document['lastName'],
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
                                        builder: (builder) =>
                                            PremiumFeatures()));
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => Noti()));
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
                  );
                }),

            //Debits Detals
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
                        '\$$totalAmount',
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
                      Column(
                        children: [
                          Text(
                            'Total Borrowers',
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
                      FutureBuilder(
                          future: docss(),
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data.toString(),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -1.50,
                              ),
                              textAlign: TextAlign.left,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Debits',
                style: GoogleFonts.inter(
                  color: colorwhite,
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
              child: StreamBuilder(
                stream: getContactsStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Debtors Details Available",
                        style: TextStyle(color: Colors.white),
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
                      String contactNames = data['contact'].join(', ');
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Name: $contactNames',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Amount: ${data['amount'].toString()}' + "\$",
                              style: TextStyle(color: Colors.white),
                            ),
                            // Add more fields as needed
                            trailing: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Actions",
                                  style: TextStyle(color: textColor),
                                )),
                          ),
                          Divider()
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//Functions
  //Contact List
  Stream<QuerySnapshot> getContactsStream() {
    return FirebaseFirestore.instance
        .collection("debitTransaction")
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //Number of Debitors
  docss() async {
    AggregateQuerySnapshot query = await FirebaseFirestore.instance
        .collection('debitTransaction')
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .count()
        .get();

    int numberOfDocuments = query.count;
    return numberOfDocuments;
  }

  //Total Amount
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
