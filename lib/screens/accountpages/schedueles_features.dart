import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/add_schedule.dart';
import 'package:oweflow/screens/main_dashboard.dart';
import 'package:oweflow/utils/colors.dart';

class SchedulesFeatures extends StatefulWidget {
  const SchedulesFeatures({super.key});

  @override
  State<SchedulesFeatures> createState() => _SchedulesFeaturesState();
}

class _SchedulesFeaturesState extends State<SchedulesFeatures> {
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
          "Schedule List",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddSchedules()));
        },
        child: Icon(
          Icons.add,
          color: colorwhite,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("schedules")
                    .where("userID",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                        "No Schedules Found yet",
                        style: TextStyle(color: black),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance
                                .collection("schedules")
                                .where("userID",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              final Map<String, dynamic> data = documents[index]
                                  .data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      data['contact'][index],
                                      style: GoogleFonts.plusJakartaSans(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data['amount'],
                                      style: GoogleFonts.plusJakartaSans(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
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
                                                      "Do you want to delete the schedule ?",
                                                      style: TextStyle(
                                                          color: black),
                                                    )
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "schedules")
                                                          .doc(data['uuid'])
                                                          .delete();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (builder) =>
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
                                          color: b,
                                        )),
                                  ),
                                  Divider(
                                    color: black.withOpacity(.2),
                                  )
                                ],
                              );
                            });
                      });
                }),
          ),
        ],
      ),
    );
  }
}
