import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/utils/colors.dart';

class CurrencyExchange extends StatefulWidget {
  const CurrencyExchange({super.key});

  @override
  State<CurrencyExchange> createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
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
              filterQuality: FilterQuality.high)),
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
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: colorwhite,
                    )),
                Text(
                  'Change Currency',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: colorwhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Noti()));
                  },
                  child: Image.asset(
                    "assets/noti.png",
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Current Currency',
                style: GoogleFonts.dmSans(
                  color: colorwhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: 0.42,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '\$',
                  style: GoogleFonts.dmSans(
                    color: b,
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Container(
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
                          hintText: "USD",
                          hintStyle: GoogleFonts.dmSans(
                              color: colorwhite, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Choose  Currency',
                style: GoogleFonts.dmSans(
                  color: colorwhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: 0.42,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '\$',
                  style: GoogleFonts.dmSans(
                    color: b,
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Container(
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
                          hintText: "Euro",
                          hintStyle: GoogleFonts.dmSans(
                              color: colorwhite, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(child: Container()),
          Container(
            margin: EdgeInsets.only(bottom: 20),
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
    ));
  }
}
