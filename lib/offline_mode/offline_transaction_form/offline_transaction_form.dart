import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
import 'package:oweflow/offline_mode/offline_contact/offline_add_contact.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class OfflineTransactionForm extends StatefulWidget {
  const OfflineTransactionForm({super.key});

  @override
  State<OfflineTransactionForm> createState() => _OfflineTransactionFormState();
}

class _OfflineTransactionFormState extends State<OfflineTransactionForm> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  bool _isLoading = false;
  List<Map<String, dynamic>> contacts = [];
  List<Map<String, dynamic>> selectedContacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    DatabaseMethod dbMethod = DatabaseMethod();
    List<Map<String, dynamic>> fetchedContacts =
        await dbMethod.getAllContacts();
    setState(() {
      contacts = fetchedContacts;
    });
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
                        builder: (builder) => PremiumFeaturesOffline()));
              },
              icon: Icon(
                Icons.menu,
                color: black,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          "Transaction Form",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _showContactDialog();
              },
              child: Text(
                'Add Contact',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: buttonColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            for (var contact in selectedContacts)
              Text(contact['name'],
                  style: TextStyle(fontSize: 16, color: colorwhite)),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Amount',
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                style: GoogleFonts.dmSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Transaction Amount",
                    labelText: "\$345",
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Notes',
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _notesController,
                maxLines: 3,
                style: GoogleFonts.dmSans(color: black),
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
                    hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Date',
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onTap: () {
                  _selectDate(); // Call Function that has showDatePicker()
                },
                controller: _dateController,
                style: GoogleFonts.dmSans(color: black),
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: black,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Date",
                    hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remainders Setup (Premium Feature)',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Activate',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: buttonColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SaveButton(
                    title: "Save",
                    onTap: () async {
                      if (selectedContacts.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("At least one contact is required")));
                        return;
                      } else if (_amountController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Amount is required")));
                        return;
                      } else if (_notesController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Notes are required")));
                        return;
                      } else if (_dateController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Date is required")));
                        return;
                      } else {
                        setState(() {
                          _isLoading = true;
                        });

                        DatabaseMethod dbMethod = DatabaseMethod();
                        for (var contact in selectedContacts) {
                          await dbMethod.inserttransactionsform({
                            'amount': int.parse(_amountController.text),
                            'notes': _notesController.text,
                            'date': _dateController.text.trim(),
                            'contact_id': contact['id'],
                            'contact_name': contact['name'],
                          });
                        }

                        setState(() {
                          _isLoading = false;
                        });

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Transaction Saved")));
                      }
                    })
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  void _showContactDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Contacts'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (var contact in contacts)
                      CheckboxListTile(
                        title: Text(contact['name']),
                        value: selectedContacts.contains(contact),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value!) {
                              selectedContacts.add(contact);
                            } else {
                              selectedContacts.remove(contact);
                            }
                          });
                        },
                      ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => AddContactOffline()));
              },
              child: Text('Add New Contact'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
