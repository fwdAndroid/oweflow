import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/utils/colors.dart';

class Noti extends StatefulWidget {
  const Noti({super.key});

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          centerTitle: true,
          title: Text(
            "Notifications",
            style: TextStyle(color: black),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
              ListView.builder(itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/splash.png"),
                  ),
                  title: Text(
                    'Contact Added',
                    style: GoogleFonts.workSans(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  subtitle: Text(
                    'Contact Added',
                    style: GoogleFonts.workSans(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Divider()
              ],
            );
          }),
        ));
  }
}
