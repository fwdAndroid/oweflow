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
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: colorwhite),
          centerTitle: true,
          title: Text(
            "Notifications",
            style: TextStyle(color: colorwhite),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/splash.png",
                  ),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover)),
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
                      color: colorwhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  subtitle: Text(
                    'Contact Added',
                    style: GoogleFonts.workSans(
                      color: colorwhite,
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
