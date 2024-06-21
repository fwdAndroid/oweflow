import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/personalprofile.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class ViewTransaction extends StatefulWidget {
  final Map<String, dynamic> document;

  ViewTransaction({super.key, required this.document});

  @override
  State<ViewTransaction> createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  late TextEditingController _amountController;
  late TextEditingController _contactController;
  late TextEditingController _notesController;
  late TextEditingController _dateController;
  late TextEditingController _dateControllerEnd;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.document['amount'].toString());
    _contactController =
        TextEditingController(text: widget.document['contact']);
    _notesController = TextEditingController(text: widget.document['notes']);
    _dateController = TextEditingController(text: widget.document['date']);
    _dateControllerEnd =
        TextEditingController(text: widget.document['duedate']);
    _statusController = TextEditingController(text: widget.document['status']);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    _dateControllerEnd.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => PersonalProfile()));
            },
            icon: Icon(
              Icons.settings,
              color: black,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Edit Transaction",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        "\$${widget.document['amount']}",
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
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                readOnly: true,
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.plusJakartaSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Amount",
                    labelText: "Amount",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                readOnly: true,
                controller: _notesController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.plusJakartaSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Notes",
                    labelText: "Notes",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                readOnly: true,
                controller: _dateController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.plusJakartaSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Date",
                    labelText: "Date",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                readOnly: true,
                controller: _dateControllerEnd,
                keyboardType: TextInputType.text,
                style: GoogleFonts.plusJakartaSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Due Date",
                    labelText: "Due Date",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                readOnly: true,
                controller: _statusController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.plusJakartaSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Status",
                    labelText: "Status",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            SaveButton(
              onTap: _updateTransaction,
              title: "Closed Transaction",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTransaction() async {
    try {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Debt Information'),
            content: SingleChildScrollView(
              child: ListTile(
                title: Text(
                  widget.document['contact'],
                  style: TextStyle(color: black),
                ),
                subtitle: Text(
                  widget.document['date'],
                  style: TextStyle(color: black),
                ),
                trailing: Text(
                  '${widget.document['amount'].toString()}\$',
                  style: TextStyle(color: black),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("closedTransaction")
                      .doc(widget.document['uuid'])
                      .set(
                    {
                      "status": "closed",
                      "amount": 0,
                      "notes": widget.document['notes'],
                      "userID": widget.document['userID'],
                      "uuid": widget.document['uuid'],
                      "contact": widget.document['contact'],
                      "date": widget.document['date'],
                      "dueDate": widget.document['duedate']
                    },
                  );
                  await FirebaseFirestore.instance
                      .collection("debitTransaction")
                      .doc(widget.document['uuid'])
                      .delete();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update transaction: $e')),
      );
    }
  }
}
