import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => PremiumFeatures()));
              },
              child: Image.asset(
                "assets/menu.png",
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Statistics',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        elevation: 0,
        backgroundColor: appBarColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/splash.png",
                ),
                fit: BoxFit.cover)),
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
                      color: Colors.white,
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
                        String contactNames = data['contact'].join(', ');
                        return Card(
                            child: ListTile(
                          title: Text(
                            'Name: $contactNames',
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
                        ));
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
