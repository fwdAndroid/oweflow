import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/offline_mode/offline_contact/offline_add_contact.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class AddScheduleOffline extends StatefulWidget {
  const AddScheduleOffline({super.key});

  @override
  State<AddScheduleOffline> createState() => _AddScheduleOfflineState();
}

class _AddScheduleOfflineState extends State<AddScheduleOffline> {
  TextEditingController _amountController = TextEditingController();
  String dropdownValue = "Does not repeat";
  String remainders = "Disabled";
  bool isLoading = false;
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

  List<Map<String, dynamic>> contacts = [];
  String? selectedContactId;
  String? selectedContactName;

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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            )),
        centerTitle: true,
        title: Text(
          "Add Schedules",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
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
                            print("Selected Contact: $selectedContactName");
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
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Add Amount',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: black,
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
                        hintText: "\$600",
                        hintStyle: GoogleFonts.inter(
                            color: black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 18),
                  child: Text(
                    "Recurrence",
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
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
                        color: black,
                      ),
                      style: TextStyle(color: Colors.black),
                      elevation: 16,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? value) {
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
                            style: TextStyle(color: black),
                          ),
                        );
                      }).toList(),
                    )),
              ],
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
                      Icons.calendar_month,
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
                    hintText: "22/12/2022",
                    hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 18),
                  child: Text(
                    "Remainders",
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
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
                        color: black,
                      ),
                      style: TextStyle(color: Colors.black),
                      elevation: 16,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? value) {
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
                            style: TextStyle(color: black),
                          ),
                        );
                      }).toList(),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading
                ? CircularProgressIndicator()
                : SaveButton(
                    title: "Save",
                    onTap: () async {
                      if (selectedContactId == null) {
                        // Add your logic to handle if no contact is selected
                        print("No contact selected");
                        return;
                      }

                      DatabaseMethod dbMethod = DatabaseMethod();

                      print(
                          "Adding Schedule for Contact ID: $selectedContactId");
                      print("Amount: ${_amountController.text}");
                      print("Notes: ${_notesController.text}");
                      print("Date: ${_dateController.text}");
                      print("Recurrence: $dropdownValue");
                      print("Remainders: $remainders");
                      print("contactName:$selectedContactName");

                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await dbMethod.insertSchedule(
                            selectedContactId!,
                            int.parse(_amountController.text),
                            _notesController.text,
                            _dateController.text,
                            dropdownValue,
                            remainders,
                            selectedContactName!);
                        print("Schedule Added Successfully");
                      } catch (e) {
                        print("Error adding schedule: $e");
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  )
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
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }
}
