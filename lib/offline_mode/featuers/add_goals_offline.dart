import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:oweflow/localdatabase/local_db.dart';
import 'package:oweflow/offline_mode/featuers/offline_finanical_goals.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class AddGoalsOffline extends StatefulWidget {
  const AddGoalsOffline({super.key});

  @override
  State<AddGoalsOffline> createState() => AddGoalsOfflineOffline();
}

class AddGoalsOfflineOffline extends State<AddGoalsOffline> {
  TextEditingController _goalName = TextEditingController();
  TextEditingController _goalAmount = TextEditingController();
  TextEditingController _goalDate = TextEditingController();
  TextEditingController _goalNote = TextEditingController();
  bool isLoading = false;
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
            "Add Goals",
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Goal Name',
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _goalName,
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
                      hintText: "Goal Name",
                      hintStyle:
                          GoogleFonts.dmSans(color: black, fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Amount',
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _goalAmount,
                  keyboardType: TextInputType.number,
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
                      hintText: "Amount",
                      hintStyle:
                          GoogleFonts.dmSans(color: black, fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Date',
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
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
                  controller: _goalDate,
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
                      hintStyle:
                          GoogleFonts.dmSans(color: black, fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Notes',
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _goalNote,
                  maxLines: 6,
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
                      hintStyle:
                          GoogleFonts.dmSans(color: black, fontSize: 12)),
                ),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : SaveButton(
                      onTap: () async {
                        if (_goalName.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Goal Name is Required is Required")));
                        } else if (_goalDate.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Date is Required")));
                        } else if (_goalAmount.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Amount is Required")));
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                        }

                        DatabaseMethod dbMethod = DatabaseMethod();

                        print("Amount: ${_goalAmount.text}");
                        print("Notes: ${_goalNote.text}");
                        print("Name: ${_goalName.text}");
                        print("Date: ${_goalDate.text}");

                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await dbMethod.insertGoal(
                            int.parse(_goalAmount.text),
                            _goalNote.text,
                            _goalName.text,
                            _goalDate.text,
                          );
                          print("Goals Added Successfully");
                        } catch (e) {
                          print("Error adding schedule: $e");
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => FinancialGoalsOffline()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Goals are added")));
                      },
                      title: "Add New Goals")
            ],
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
        _goalDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
}
