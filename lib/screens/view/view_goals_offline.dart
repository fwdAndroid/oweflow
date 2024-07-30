import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/utils/buttons.dart';

class ViewGoalsOffline extends StatefulWidget {
  final Map<String, dynamic> document;

  ViewGoalsOffline({Key? key, required this.document}) : super(key: key);

  @override
  _ViewGoalsOfflineState createState() => _ViewGoalsOfflineState();
}

class _ViewGoalsOfflineState extends State<ViewGoalsOffline> {
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  late TextEditingController _dateController;
  late TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.document['amount'].toString());
    _notesController = TextEditingController(text: widget.document['notes']);
    _dateController = TextEditingController(text: widget.document['date']);

    _contactController = TextEditingController(text: widget.document['name']);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Schedules'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Current Balance',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '\$${widget.document['amount']}',
                style: GoogleFonts.inter(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildTextField(
              controller: _contactController,
              labelText: 'Name',
              readOnly: true,
            ),
            buildTextField(
              controller: _amountController,
              labelText: 'Amount',
              readOnly: true,
            ),
            buildTextField(
              controller: _notesController,
              labelText: 'Notes',
              readOnly: true,
            ),
            buildTextField(
              controller: _dateController,
              labelText: 'Date',
              readOnly: true,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SaveButton(
                onTap: () async {
                  try {
                    // Prepare transaction data to move to completedtransactions table

                    // Perform database operations to move transaction

                    await DatabaseMethod().deleteGoals(widget.document['id']);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Delete Goals')),
                    );

                    // Navigate back after successful closure
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to close transaction: $e')),
                    );
                  }
                },
                title: 'Close Goals',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
