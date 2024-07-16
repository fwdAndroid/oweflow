import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';
import 'package:oweflow/localdatabase/local_db.dart'; // Ensure this is the correct path

class EditLendPageOffline extends StatefulWidget {
  final Map<String, dynamic> document;
  EditLendPageOffline({super.key, required this.document});

  @override
  State<EditLendPageOffline> createState() => _EditLendPageOfflineState();
}

class _EditLendPageOfflineState extends State<EditLendPageOffline> {
  late TextEditingController _amountController;
  late TextEditingController _contactController;
  late TextEditingController _notesController;
  late TextEditingController _dateController;
  late TextEditingController _dateControllerEnd;

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
  }

  @override
  void dispose() {
    _amountController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
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
                  hintText: "Enter Amount",
                  labelText: "Enter Amount",
                  hintStyle:
                      GoogleFonts.plusJakartaSans(color: black, fontSize: 12),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
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
                  hintText: "Enter Notes",
                  labelText: "Enter Notes",
                  hintStyle:
                      GoogleFonts.plusJakartaSans(color: black, fontSize: 12),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onTap: () {
                  _selectDate(); // Call Function that has showDatePicker()
                },
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
                  hintText: "Enter Date",
                  labelText: "Enter Date",
                  hintStyle:
                      GoogleFonts.plusJakartaSans(color: black, fontSize: 12),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onTap: () {
                  _selectDateEnd(); // Call Function that has showDatePicker()
                },
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
                  hintText: "Enter Due Date",
                  labelText: "Enter Due Date",
                  hintStyle:
                      GoogleFonts.plusJakartaSans(color: black, fontSize: 12),
                ),
              ),
            ),
            SaveButton(
              onTap: _updateTransaction,
              title: "Update Transaction",
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      // Update the text field with the selected date
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _selectDateEnd() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      // Update the text field with the selected date
      setState(() {
        _dateControllerEnd.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _updateTransaction() async {
    try {
      // Update transaction in SQLite database
      DatabaseMethod dbMethod = DatabaseMethod();
      await dbMethod.updateTransaction({
        'id': widget.document['id'],
        'amount': int.parse(_amountController.text),
        'contact': _contactController.text,
        'notes': _notesController.text,
        'date': _dateController.text,
        'duedate': _dateControllerEnd.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaction updated successfully')),
      );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update transaction: $e')),
      );
    }
  }
}
