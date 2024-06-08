import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/featuers/offline_pre_features.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';
import 'package:uuid/uuid.dart';

class AddContactOffline extends StatefulWidget {
  const AddContactOffline({super.key});

  @override
  State<AddContactOffline> createState() => _AddContactOfflineState();
}

class _AddContactOfflineState extends State<AddContactOffline> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  bool isLoading = false;
  var uuid = Uuid().v4();
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
          "Add Contacts",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Name',
                style: GoogleFonts.plusJakartaSans(
                    color: black, fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _nameController,
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
                  hintText: "Enter Person Name",
                  hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Email',
                style: GoogleFonts.plusJakartaSans(
                    color: black, fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _emailController,
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
                  hintText: "Enter Email",
                  hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Phone Number',
                style: GoogleFonts.plusJakartaSans(
                    color: black, fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _phoneNumberController,
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
                  hintText: "Enter Phone Number",
                  hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      width: 150,
                      child: SaveButton(
                        onTap: () async {
                          // if (_nameController.text.isEmpty ||
                          //     _emailController.text.isEmpty ||
                          //     _phoneNumberController.text.isEmpty) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text("All Fields Required")));
                          // } else {
                          //   setState(() {
                          //     isLoading = true;
                          //   });
                          //   await FirebaseFirestore.instance
                          //       .collection("contacts")
                          //       .doc(uuid)
                          //       .set({
                          //     "uid": FirebaseAuth.instance.currentUser!.uid,
                          //     "name": _nameController.text,
                          //     "email": _emailController.text,
                          //     "phone": _phoneNumberController.text
                          //   });

                          //   setState(() {
                          //     isLoading = false;
                          //   });
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       content: Text("Contact Added Successfully")));
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (builder) => MainDashboard()));
                          // }
                        },
                        title: "Save",
                      ),
                    ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.inter(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
