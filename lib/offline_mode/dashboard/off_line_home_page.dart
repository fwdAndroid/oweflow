import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
import 'package:oweflow/offline_mode/off_line_edit/edit_lend_page_offline.dart';
import 'package:oweflow/utils/colors.dart';

class OfflineHomePage extends StatefulWidget {
  const OfflineHomePage({super.key});

  @override
  State<OfflineHomePage> createState() => _OfflineHomePageState();
}

class _OfflineHomePageState extends State<OfflineHomePage> {
  var totalAmount = 0;
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    calculateTotalAmount();
    fetchTransactions();
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

  Future<void> fetchTransactions() async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      List<Map<String, dynamic>> fetchedTransactions =
          await dbMethod.getAllTransactions();
      setState(() {
        transactions = fetchedTransactions;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  Future<void> completeTransaction(Map<String, dynamic> transaction) async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      await dbMethod.insertCompletedTransaction(transaction);
      await dbMethod.deleteTransaction(transaction['id']);
      fetchTransactions();
      calculateTotalAmount();
    } catch (e) {
      print('Error completing transaction: $e');
    }
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
          // Debits Details
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
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (builder) => Lenders()));
                    },
                    child: Image.asset(
                      "assets/Card.png",
                      height: 90,
                      width: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (builder) => Borrowers()));
                    },
                    child: Image.asset(
                      "assets/Card (1).png",
                      height: 90,
                      width: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (builder) => CurrencyExchange()));
                    },
                    child: Image.asset(
                      "assets/Card (2).png",
                      height: 90,
                      width: 90,
                    ),
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
              height: MediaQuery.of(context).size.height / 2.3,
              child: transactions.isEmpty
                  ? Center(
                      child: Text(
                        'No transactions available',
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
                        bool isReceived = transaction['status'] == 'Received';
                        Color amountColor =
                            isReceived ? Colors.green : Colors.red;
                        String message =
                            isReceived ? "You Borrowed" : "You Lent";

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
                      },
                    ))
        ]));
  }
}
