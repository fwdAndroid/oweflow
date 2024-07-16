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
  TextEditingController _dateControllerEnd = TextEditingController();

  bool _isLoading = false;
  List<Map<String, dynamic>> contacts = [];
  String? selectedContactId;
  String? selectedContactName;

  String? _selectedValue = 'Received';
  var _value = false;

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
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => AddContactOffline()));
                },
                child: Text("Add Contact")),
            SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: contacts.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        var contact = contacts[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedContactId = contact['id'].toString();
                              selectedContactName = contact['name'];
                            });
                            print(selectedContactName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: selectedContactName == contact['name']
                                      ? Colors
                                          .green // Change color to green when selected
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    contact['name'],
                                    style: GoogleFonts.plusJakartaSans(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : Text("No Contact Found Yet"),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio<String>(
                  value: 'Received',
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Text('Received'),
                Radio<String>(
                  value: 'Gave',
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Text('Gave'),
              ],
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
                    labelText: "Amount",
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _notesController,
                maxLines: 1,
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
                    hintText: "Description",
                    hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
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
                      Icons.keyboard_arrow_down,
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
                    labelText: "Date",
                    hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onTap: () {
                  _selectDateEnd(); // Call Function that has showDatePicker()
                },
                controller: _dateControllerEnd,
                style: GoogleFonts.dmSans(color: black),
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
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
                    hintText: "Due Date",
                    labelText: "Due Date",
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
                    'Activate Premium',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: g,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            CheckboxListTile(
              title: Text(
                'SMS, WhatsApp, or Email.',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: black,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              autofocus: false,
              checkColor: black,
              selected: _value,
              value: _value,
              onChanged: (bool? value) {
                setState(() {
                  _value = value!;
                });
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Remainders Setup (Premium Feature)',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: black,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              autofocus: false,
              checkColor: black,
              selected: _value,
              value: _value,
              onChanged: (bool? value) {
                setState(() {
                  _value = value!;
                });
              },
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
                      if (selectedContactId == null ||
                          selectedContactName == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("A contact must be selected")));
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
                        await dbMethod.inserttransactionsform({
                          'amount': int.parse(_amountController.text),
                          'notes': _notesController.text,
                          'date': _dateController.text.trim(),
                          "duedate": _dateControllerEnd.text.trim(),
                          'contact_id': int.parse(selectedContactId!),
                          'contact_name': selectedContactName!,
                          'status': _selectedValue,
                        });

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

  void _selectDateEnd() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateControllerEnd.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
}
