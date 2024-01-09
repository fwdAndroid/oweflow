import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/utils/colors.dart';

class Lenders extends StatefulWidget {
  const Lenders({super.key});

  @override
  State<Lenders> createState() => _LendersState();
}

class _LendersState extends State<Lenders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/splash.png",
              ),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover)),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/splash.png"),
                  ),
                  trailing: Text(
                    '500\$',
                    style: GoogleFonts.lato(
                      color: colorwhite,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  title: Text(
                    'Subodh Kolhe',
                    style: GoogleFonts.lato(
                      color: colorwhite,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  subtitle: Text(
                    'You owe',
                    style: GoogleFonts.lato(
                      color: colorwhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
