import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart'; // Ensure this import is correct
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
import 'package:oweflow/utils/colors.dart';

class WalletPageOffline extends StatefulWidget {
  const WalletPageOffline({super.key});

  @override
  State<WalletPageOffline> createState() => _WalletPageOfflineState();
}

class _WalletPageOfflineState extends State<WalletPageOffline> {
  var totalAmount = 0;
  List<Map<String, dynamic>> currentTransactions = [];
  List<Map<String, dynamic>> closedTransactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
    fetchCompletedTransactions();
    calculateTotalAmount();
  }

  Future<void> fetchTransactions() async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      List<Map<String, dynamic>> transactions =
          await dbMethod.getAllTransactions();

      setState(() {
        currentTransactions = transactions;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  Future<void> fetchCompletedTransactions() async {
    try {
      DatabaseMethod dbMethod = DatabaseMethod();
      List<Map<String, dynamic>> transactions =
          await dbMethod.getAllCompletedTransactions();

      setState(() {
        closedTransactions = transactions;
      });
    } catch (e) {
      print('Error fetching completed transactions: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => PremiumFeaturesOffline()),
              );
            },
            icon: Icon(
              Icons.menu,
              color: black,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "Transaction Details",
          style: GoogleFonts.plusJakartaSans(
            color: black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
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
                        color: colorwhite,
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
          const SizedBox(
            height: 30,
          ),
          Text(
            "Current Transactions",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: currentTransactions.isEmpty
                  ? Center(child: Text('No current transactions available'))
                  : ListView.builder(
                      itemCount: currentTransactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        var transaction = currentTransactions[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Name: ${transaction['contact_name']}',
                                style: TextStyle(color: black),
                              ),
                              subtitle: Text(
                                'Amount: ${transaction['amount'].toString()}',
                                style: TextStyle(color: black),
                              ),
                              trailing: Text(
                                transaction['status'].toString().toUpperCase(),
                                style: TextStyle(color: g),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
            ),
          ),
          Text(
            "Closed Transactions",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: closedTransactions.isEmpty
                  ? Center(child: Text('No closed transactions available'))
                  : ListView.builder(
                      itemCount: closedTransactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        var transaction = closedTransactions[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Name: ${transaction['contact_name']}',
                                style: TextStyle(color: black),
                              ),
                              subtitle: Text(
                                'Amount: ${transaction['amount'].toString()}',
                                style: TextStyle(color: black),
                              ),
                              trailing: Text(
                                transaction['date'].toString().toUpperCase(),
                                style: TextStyle(color: g),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
