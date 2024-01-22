import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/show_contact.dart';
import 'package:oweflow/utils/colors.dart';
import 'package:intl/intl.dart';

class AddSchedules extends StatefulWidget {
  const AddSchedules({super.key});

  @override
  State<AddSchedules> createState() => _AddSchedulesState();
}

class _AddSchedulesState extends State<AddSchedules> {
  TextEditingController _emailController = TextEditingController();
  String dropdownValue = "Does not repeat";
  String remainders = "Disabled";
  List<String> listRecrudesce = <String>[
    'Does not repeat',
    'Every 2 weeks',
    'Every month',
  ];
  List<String> listRemainders = <String>[
    'Disabled',
    'Weekly',
    'Bi-Weekly',
    'Monthly'
  ];
  TextEditingController _dateController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  List<String> selectedContacts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add Schedules',
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
              const SizedBox(
                height: 30,
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
                                        value:
                                            selectedContacts.contains(contact),
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
                                      builder: (builder) => ShowContact()));
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
              const SizedBox(
                height: 20,
              ),
              for (String contact in selectedContacts)
                Text(contact,
                    style: TextStyle(fontSize: 16, color: colorwhite)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Add Amount',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    width: 130,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _emailController,
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
                          hintText: "\$600",
                          hintStyle: GoogleFonts.inter(
                              color: colorwhite,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 18),
                    child: Text(
                      "Recurrence",
                      style: GoogleFonts.inter(color: colorwhite),
                    ),
                  ),
                  Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: borderColor)),
                      margin: const EdgeInsets.only(left: 18, right: 18),
                      padding: const EdgeInsets.all(8),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: colorwhite,
                        ),
                        dropdownColor: Colors.transparent,
                        style: TextStyle(color: Colors.black),
                        elevation: 16,
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: listRecrudesce
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: colorwhite),
                            ),
                          );
                        }).toList(),
                      )),
                ],
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
                        Icons.calendar_month,
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
                      hintText: "Dates",
                      hintStyle:
                          GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 18),
                    child: Text(
                      "Remainders",
                      style: GoogleFonts.inter(color: colorwhite),
                    ),
                  ),
                  Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: borderColor)),
                      margin: const EdgeInsets.only(left: 18, right: 18),
                      padding: const EdgeInsets.all(8),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: remainders,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: colorwhite,
                        ),
                        dropdownColor: Colors.transparent,
                        style: TextStyle(color: Colors.black),
                        elevation: 16,
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            remainders = value!;
                          });
                        },
                        items: listRemainders
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: colorwhite),
                            ),
                          );
                        }).toList(),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 343,
                height: 56,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
            ],
          ),
        ),
      ),
    );
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
