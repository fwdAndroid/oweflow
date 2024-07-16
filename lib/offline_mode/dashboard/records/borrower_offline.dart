import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/offline_mode/off_line_edit/edit_lend_page_offline.dart';
import 'package:oweflow/utils/colors.dart';

class BorrowersOffline extends StatefulWidget {
  const BorrowersOffline({super.key});

  @override
  State<BorrowersOffline> createState() => _BorrowersOfflineState();
}

class _BorrowersOfflineState extends State<BorrowersOffline> {
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
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (builder) => PersonalProfile()));
            },
            icon: Icon(
              Icons.settings,
              color: black,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Lenders",
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
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: DatabaseMethod().getAllTransactionsReceived(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Or any loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No transactions found.');
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var transaction = snapshot.data![index];
                            bool isReceived =
                                transaction['status'] == 'Received';
                            Color amountColor =
                                isReceived ? Colors.green : Colors.red;
                            String message =
                                isReceived ? "You Borrowed" : "You Lent";
                            return Dismissible(
                              key: Key(transaction['id'].toString()),
                              confirmDismiss:
                                  (DismissDirection direction) async {
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
                                                Navigator.of(context)
                                                    .pop(false),
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
                                      builder: (context) => EditLendPageOffline(
                                          document: transaction),
                                    ),
                                  );
                                  return false;
                                }
                                return false;
                              },
                              onDismissed: (DismissDirection direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  // delete transaction detail in SQlite database and here'
                                  DatabaseMethod dbMethod = DatabaseMethod();
                                  await dbMethod
                                      .deleteTransaction(transaction['id']);
                                  setState(() {
                                    transaction.clear();
                                  });
                                }
                              },
                              background: Container(
                                  color: Colors.green,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child:
                                          Icon(Icons.edit, color: Colors.white),
                                    ),
                                  )),
                              secondaryBackground: Container(
                                  color: Colors.red,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  )),
                              child: Card(
                                elevation: 1,
                                color: colorwhite,
                                child: ListTile(
                                  title: Text(
                                    transaction['contact_name'],
                                    style: GoogleFonts.plusJakartaSans(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        message,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: amountColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
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
                          });
                    }
                  })),
        ],
      ),
    );
  }

  Future<void> calculateTotalAmount() async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      int amount = await dbMethod.calculateTotalAmount();
      setState(() {
        totalAmount = amount;
      });
    } catch (e) {
      print('Error calculating total amount: $e');
    }
  }
}
