import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/premium_features.dart';
import 'package:oweflow/utils/colors.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
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
                  'Add Contacts',
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
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
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
                  hintText: "Enter Person Name",
                  hintStyle:
                      GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
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
                  hintText: "Enter Email",
                  hintStyle:
                      GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
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
                  hintText: "Enter Phone Number",
                  hintStyle:
                      GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 165,
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
              const SizedBox(
                width: 20,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
