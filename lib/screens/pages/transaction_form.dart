import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/add_contact.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/screens/main_dashboard.dart';
import 'package:oweflow/utils/buttons.dart';
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
  TextEditingController _amountController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateControllerEnd = TextEditingController();
  var _value = false;
  bool _isLoading = false;
  String? _selectedValue = 'Received';
  String? selectedContact; // Add this line to store the selected contact

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
                          builder: (builder) => PremiumFeatures()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AddContact()));
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Recent Contacts',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("contacts")
                        .where("uid",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No Chat Started Yet",
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              final Map<String, dynamic> data = documents[index]
                                  .data() as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedContact = data['name'];
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: selectedContact == data['name']
                                            ? Colors
                                                .green // Change color to green when selected
                                            : Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data['name'],
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
                            }),
                      );
                    }),
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
                      hintStyle:
                          GoogleFonts.dmSans(color: black, fontSize: 12)),
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
                      hintStyle:
                          GoogleFonts.dmSans(color: black, fontSize: 12)),
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
                      hintStyle:
                          GoogleFonts.dmSans(color: black, fontSize: 12)),
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
                        var uuid = Uuid().v4();
                        if (selectedContact == null) {
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
                            "contact": selectedContact,
                            "amount": int.parse(_amountController.text),
                            "date": _dateController.text.trim(),
                            "duedate": _dateControllerEnd.text.trim(),
                            "notes": _notesController.text,
                            "status": _selectedValue
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
                      })
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
}
