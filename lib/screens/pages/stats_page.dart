import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/screens/pages/tab_pages/edit_lend_page.dart';
import 'package:oweflow/utils/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

final now = DateTime.now();

final currentMonth = DateTime(now.year, now.month, 1);

class _StatsPageState extends State<StatsPage> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> eventDates = [];

  @override
  void initState() {
    super.initState();
    fetchEvents().then((dates) {
      setState(() {
        eventDates = dates;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Statistics",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Spending',
                    style: GoogleFonts.inter(
                      color: Colors.black,
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
            SfCalendar(
              view: CalendarView.month,
              initialDisplayDate: currentMonth,
              initialSelectedDate: selectedDate,
              backgroundColor: Colors.white,
              blackoutDatesTextStyle: const TextStyle(color: Colors.white),
              cellBorderColor: Colors.white,
              selectionDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              todayHighlightColor: Colors.amber,
              appointmentTextStyle: TextStyle(color: Colors.white),
              dataSource: _getCalendarDataSource(),
              onTap: (CalendarTapDetails details) {
                setState(() {
                  selectedDate = details.date!;
                });
              },
            ),
            Container(
              height: 220,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('debitTransaction')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center();
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Debtors Details Available",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  List<DocumentSnapshot> eventDocs = snapshot.data!.docs;
                  List<DocumentSnapshot> filteredEvents =
                      eventDocs.where((event) {
                    String eventDate = event['date'] as String;
                    String selectedDateString =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    return eventDate == selectedDateString;
                  }).toList();

                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        var data = filteredEvents[index].data()
                            as Map<String, dynamic>;

                        return Dismissible(
                            key: Key(filteredEvents[index].id),
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Confirm"),
                                      content: Text(
                                          "Are you sure you want to delete this item?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditLendPage(document: data),
                                  ),
                                );
                                return false;
                              }
                              return false;
                            },
                            onDismissed: (DismissDirection direction) async {
                              if (direction == DismissDirection.endToStart) {
                                await FirebaseFirestore.instance
                                    .collection('debitTransaction')
                                    .doc(filteredEvents[index].id)
                                    .delete();
                                setState(() {
                                  filteredEvents.removeAt(index);
                                });
                              }
                            },
                            background: Container(
                                color: Colors.green,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child:
                                        Icon(Icons.edit, color: Colors.white),
                                  ),
                                )),
                            secondaryBackground: Container(
                                color: Colors.red,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                )),
                            child: Card(
                                child: ListTile(
                              title: Text(
                                data['contact'],
                                style: TextStyle(color: textColor),
                              ),
                              subtitle: Text(
                                'Amount: ${data['amount'].toString()}' + "\$",
                                style: TextStyle(color: textColor),
                              ),
                              trailing: Text(
                                data['status'].toString().toUpperCase(),
                                style: TextStyle(color: textColor),
                              ),
                            )));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<DateTime>> fetchEvents() async {
    // Fetch data from two collections simultaneously using Future.wait
    List<QuerySnapshot<Map<String, dynamic>>> snapshots = await Future.wait([
      FirebaseFirestore.instance.collection('closedTransaction').get(),
      FirebaseFirestore.instance.collection('debitTransaction').get(),
    ]);

    // Extract dates from both collections
    List<DateTime> eventDates = [];
    for (QuerySnapshot<Map<String, dynamic>> snapshot in snapshots) {
      eventDates.addAll(snapshot.docs
          .map((doc) => DateTime.parse(doc.data()['date']))
          .toList());
    }

    return eventDates;
  }

  _DataSource _getCalendarDataSource() {
    List<Appointment> appointments = [];

    for (DateTime date in eventDates) {
      appointments.add(Appointment(
        startTime: date,
        endTime: date.add(Duration(hours: 1)),
        isAllDay: true,
        color: Colors.orange,
      ));
    }

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
