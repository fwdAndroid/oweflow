import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/utils/buttons.dart';

class ViewOfflineSchedules extends StatefulWidget {
  final Map<String, dynamic> document;

  ViewOfflineSchedules({Key? key, required this.document}) : super(key: key);

  @override
  _ViewOfflineSchedulesState createState() => _ViewOfflineSchedulesState();
}

class _ViewOfflineSchedulesState extends State<ViewOfflineSchedules> {
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  late TextEditingController _dateController;
  late TextEditingController _dateControllerEnd;
  late TextEditingController _statusController;
  late TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.document['amount'].toString());
    _notesController = TextEditingController(text: widget.document['notes']);
    _dateController = TextEditingController(text: widget.document['date']);
    _dateControllerEnd =
        TextEditingController(text: widget.document['listRecrudesce']);
    _statusController =
        TextEditingController(text: widget.document['listRemainders']);
    _contactController =
        TextEditingController(text: widget.document['contact_name']);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    _dateControllerEnd.dispose();
    _statusController.dispose();
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
              labelText: 'Contact Name',
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
            buildTextField(
              controller: _dateControllerEnd,
              labelText: 'Recrudesce',
              readOnly: true,
            ),
            buildTextField(
              controller: _statusController,
              labelText: 'Remainders',
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

                    await DatabaseMethod()
                        .deleteSchedules(widget.document['id']);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Delete Schedule')),
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
                title: 'Close Schedule',
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
