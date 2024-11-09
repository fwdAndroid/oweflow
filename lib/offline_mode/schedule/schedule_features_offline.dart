import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/offline_mode/off_line_edit/edit_lend_page_offline.dart';
import 'package:oweflow/offline_mode/schedule/add_schedule_offline.dart';
import 'package:oweflow/screens/view/view_offline_schedules.dart';
import 'package:oweflow/utils/colors.dart';

class ScheduleFeaturesOffline extends StatefulWidget {
  const ScheduleFeaturesOffline({super.key});

  @override
  State<ScheduleFeaturesOffline> createState() =>
      _ScheduleFeaturesOfflineState();
}

class _ScheduleFeaturesOfflineState extends State<ScheduleFeaturesOffline> {
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      List<Map<String, dynamic>> fetchedTransactions =
          await dbMethod.getSchedules();
      setState(() {
        transactions = fetchedTransactions;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

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
          ),
        ),
        centerTitle: true,
        title: Text(
          "Schedule List",
          style: GoogleFonts.plusJakartaSans(
            color: black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => AddScheduleOffline()),
          );
        },
        child: Icon(
          Icons.add,
          color: colorwhite,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.3,
            child: transactions.isEmpty
                ? Center(
                    child: Text(
                      'No Schedules available',
                      style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final transaction = transactions[index];

                      return Dismissible(
                        key: Key(transaction['id'].toString()),
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
                          } else if (direction == DismissDirection.startToEnd) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditLendPageOffline(document: transaction),
                              ),
                            );
                            return false;
                          }
                          return false;
                        },
                        onDismissed: (DismissDirection direction) async {
                          if (direction == DismissDirection.endToStart) {
                            DatabaseMethod dbMethod = DatabaseMethod();
                            await dbMethod.deleteSchedules(transaction['id']);
                            setState(() {
                              transactions.removeAt(index);
                            });
                          }
                        },
                        background: Container(
                          color: Colors.green,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                        child: Card(
                          elevation: 1,
                          color: colorwhite,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => ViewOfflineSchedules(
                                      document: transaction),
                                ),
                              );
                            },
                            title: Text(
                              transaction['contact_name'].toString(),
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
                                  transaction['notes'],
                                  style: GoogleFonts.plusJakartaSans(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  transaction['date'],
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
                                  '\$${transaction['amount']}',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
