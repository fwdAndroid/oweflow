import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/main_dashboard.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: colorwhite),
        centerTitle: true,
        title: Text(
          "Personal Profile",
          style: TextStyle(color: colorwhite),
        ),
      ),
      backgroundColor: black,
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            var document = snapshot.data;
            firstNameController.text = document['firstName'];
            lastNameController.text = document['lastName'];

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/splash.png",
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/uiux logos 1.png",
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: firstNameController,
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
                            hintText: "First Name",
                            hintStyle: GoogleFonts.dmSans(
                                color: colorwhite, fontSize: 12)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: lastNameController,
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
                            hintText: "Last Name",
                            hintStyle: GoogleFonts.dmSans(
                                color: colorwhite, fontSize: 12)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SaveButton(
                            title: "Edit Profile",
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "lastName": lastNameController.text,
                                "firstName": firstNameController.text,
                              }).then((value) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "User Profile Updated")))
                                      });
                              lastNameController.clear();
                              firstNameController.clear();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MainDashboard()));
                            }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
