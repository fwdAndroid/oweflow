import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart'; // Ensure this import is correct
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/screens/view/view_offline_transaction.dart';
import 'package:oweflow/screens/view/view_transaction.dart';
import 'package:oweflow/utils/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class StatsPageOffline extends StatefulWidget {
  const StatsPageOffline({super.key});

  @override
  State<StatsPageOffline> createState() => _StatsPageOfflineState();
}

final now = DateTime.now();
final currentMonth = DateTime(now.year, now.month, 1);

class _StatsPageOfflineState extends State<StatsPageOffline> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> eventDates = [];
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
    fetchTransactions();
  }

  Future<void> fetchEvents() async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      List<Map<String, dynamic>> allTransactions =
          await dbMethod.getAllTransactions();
      List<Map<String, dynamic>> completedTransactions =
          await dbMethod.getAllCompletedTransactions();

      setState(() {
        eventDates = [
          ...allTransactions
              .map((transaction) => DateTime.parse(transaction['date']))
              .toList(),
          ...completedTransactions
              .map((transaction) => DateTime.parse(transaction['date']))
              .toList(),
        ];
      });
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> fetchTransactions() async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      List<Map<String, dynamic>> allTransactions =
          await dbMethod.getAllTransactions();
      List<Map<String, dynamic>> completedTransactions =
          await dbMethod.getAllCompletedTransactions();

      setState(() {
        transactions = [...allTransactions, ...completedTransactions];
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTransactions = transactions
        .where((transaction) =>
            DateTime.parse(transaction['date']).day == selectedDate.day)
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => PremiumFeatures(),
              ),
            );
          },
          icon: Icon(
            Icons.menu,
            color: black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Statistics",
          style: GoogleFonts.plusJakartaSans(
            color: black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
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
              dataSource: _getCalendarDataSource(eventDates),
              onTap: (CalendarTapDetails details) {
                setState(() {
                  selectedDate = details.date!;
                });
              },
            ),
            Container(
              height: 220,
              child: filteredTransactions.isEmpty
                  ? Center(
                      child: Text(
                        'No transactions available for the selected date',
                        style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        var transaction = filteredTransactions[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          ViewOfflineTransaction(
                                            document: transaction,
                                          )));
                            },
                            title: Text(
                              '${transaction['contact_name']}',
                              style: TextStyle(color: textColor),
                            ),
                            subtitle: Text(
                              ' ${transaction['amount'].toString()}' + "\$",
                              style: TextStyle(color: textColor),
                            ),
                            trailing: Text(
                              transaction['status'].toString().toUpperCase(),
                              style: TextStyle(color: textColor),
                            ),
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

  _DataSource _getCalendarDataSource(List<DateTime> eventDates) {
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
