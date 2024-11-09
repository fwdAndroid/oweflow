import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/add_contact.dart';
import 'package:oweflow/utils/colors.dart';

class ShowContact extends StatefulWidget {
  const ShowContact({super.key});

  @override
  State<ShowContact> createState() => _ShowContactState();
}

class _ShowContactState extends State<ShowContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: textColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddContact()));
        },
        child: Icon(
          Icons.add,
          color: colorwhite,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/back.png",
              ),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: colorwhite,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Contact List',
                    style: GoogleFonts.inter(
                      color: colorwhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("contacts")
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
                          "No Contact Found yet",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance
                                  .collection("contacts")
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
                                      title: Text(
                                        data['name'],
                                        style: TextStyle(
                                            color: colorwhite,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        data['phone'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
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
          ],
        ),
      ),
    );
  }
}
