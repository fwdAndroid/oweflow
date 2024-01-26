import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/add_contact.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/screens/main_dashboard.dart';
import 'package:oweflow/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Animals { received, gave }

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  Animals? _animal = Animals.received;
  TextEditingController _amountController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  var _value = false;
  bool _isLoading = false;
  List<String> selectedContacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/back.png",
            ),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: colorwhite,
                    ),
                  ),
                  Text(
                    'Transaction Form',
                    style: GoogleFonts.inter(
                      color: colorwhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => PremiumFeatures()));
                    },
                    child: Image.asset(
                      "assets/menu.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select Contacts'),
                      content: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return FutureBuilder(
                          future: fetchContacts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<String> contacts =
                                  snapshot.data as List<String>;

                              return Column(
                                children: [
                                  for (String contact in contacts)
                                    CheckboxListTile(
                                      title: Text(contact),
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
                              );
                            }
                          },
                        );
                      }),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => AddContact()));
                          },
                          child: Text('Add New Contact'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Do something with selectedContacts
                            // For now, just print them
                            print('Selected Contacts: $selectedContacts');
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Add Contact',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: b,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            for (String contact in selectedContacts)
              Text(contact, style: TextStyle(fontSize: 16, color: colorwhite)),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Align(
            //     alignment: AlignmentDirectional.topStart,
            //     child: Text(
            //       'Type of Transaction',
            //       textAlign: TextAlign.center,
            //       style: GoogleFonts.inter(
            //         color: colorwhite,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400,
            //         height: 0,
            //       ),
            //     ),
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(
            //         child: ListTile(
            //       contentPadding: const EdgeInsets.all(0),
            //       title: const Text(
            //         'Received',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       leading: Radio<Animals>(
            //         value: Animals.received,
            //         groupValue: _animal,
            //         onChanged: (Animals? value) {
            //           setState(() {
            //             _animal = value;
            //           });
            //           debugPrint(_animal!.name);
            //         },
            //       ),
            //     )),
            //     Expanded(
            //       child: ListTile(
            //         contentPadding: const EdgeInsets.all(0),
            //         title: const Text(
            //           'Gave',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //         leading: Radio<Animals>(
            //           value: Animals.gave,
            //           groupValue: _animal,
            //           onChanged: (Animals? value) {
            //             setState(() {
            //               _animal = value;
            //             });
            //             debugPrint(_animal!.name);
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                style: GoogleFonts.dmSans(color: colorwhite),
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
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _notesController,
                maxLines: 3,
                style: GoogleFonts.dmSans(color: colorwhite),
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
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
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
                style: GoogleFonts.dmSans(color: colorwhite),
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: colorwhite,
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
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
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
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Activate',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Color(0xFFE84040),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            CheckboxListTile(
              title: Text(
                'SMS, WhatsApp, or Email.  ',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              autofocus: false,
              checkColor: Colors.white,
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
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              autofocus: false,
              checkColor: Colors.white,
              selected: _value,
              value: _value,
              onChanged: (bool? value) {
                setState(() {
                  _value = value!;
                });
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Align(
            //     alignment: AlignmentDirectional.topStart,
            //     child: Text(
            //       'Upload Image',
            //       textAlign: TextAlign.center,
            //       style: GoogleFonts.inter(
            //         color: Colors.white,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400,
            //         height: 0,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    onTap: () async {
                      var uuid = Uuid().v4();
                      if (selectedContacts.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Contact is Required")));
                      } else if (_amountController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Amount is Required")));
                      } else if (_notesController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Notes is Required")));
                      } else if (_dateController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Date is Required")));
                      } else {
                        setState(() {
                          _isLoading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection("debitTransaction")
                            .doc(uuid)
                            .set({
                          "userID": FirebaseAuth.instance.currentUser!.uid,
                          "uuid": uuid,
                          "contact": selectedContacts,
                          "amount": int.parse(_amountController.text),
                          "date": _dateController.text.trim(),
                          "notes": _notesController.text,
                        });
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MainDashboard()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Debit is Created")));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: 250,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: textColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: colorwhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    ));
  }

//Functions
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

  Future<List<String>> fetchContacts() async {
    // Replace 'your_collection_name' with the actual name of your Firestore collection
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('contacts').get();

    List<String> contacts = [];

    querySnapshot.docs.forEach((doc) {
      // Assuming each document in the collection has a field with the contact name
      String contactName = doc['name'];
      contacts.add(contactName);
    });

    return contacts;
  }
}
