import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
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
                        return Card(
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
                            trailing: Row(
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
                                IconButton(
                                    onPressed: () async {
                                      await completeTransaction(transaction);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Transaction is Settled")));
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
