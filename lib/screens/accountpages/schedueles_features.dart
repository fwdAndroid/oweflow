import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/accountpages/add_schedule.dart';
import 'package:oweflow/utils/colors.dart';

class SchedulesFeatures extends StatefulWidget {
  const SchedulesFeatures({super.key});

  @override
  State<SchedulesFeatures> createState() => _SchedulesFeaturesState();
}

class _SchedulesFeaturesState extends State<SchedulesFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: textColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddSchedules()));
        },
        child: Icon(
          Icons.add,
          color: colorwhite,
        ),
      ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Schedule List',
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/splash.png"),
                      ),
                      trailing: Text(
                        '5345\$',
                        style: GoogleFonts.workSans(
                          color: Color(0xFF6C757D),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      title: Text(
                        'Schedule 2134',
                        style: GoogleFonts.workSans(
                          color: colorwhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      subtitle: Text(
                        'Created At 23 September 2032',
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
            ),
          ],
        ),
      ),
    );
  }
}
